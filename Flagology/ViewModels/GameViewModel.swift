import Foundation

class GameViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var currentQuestion: Question?
    @Published var score = 0
    @Published var questionCount = 0
    @Published var selectedQuestionCount: Int?
    @Published var isGameOver = false

    private var usedCountries: Set<String> = []

    struct Question {
        let correctCountry: Country
        let options: [Country]
        let correctAnswerIndex: Int
    }

    func fetchCountries() async {
        do {
            let url = URL(string: "https://restcountries.com/v3.1/all?fields=name,flags")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedCountries = try JSONDecoder().decode([Country].self, from: data)
            DispatchQueue.main.async {
                self.countries = decodedCountries
                if self.selectedQuestionCount != nil {
                    self.generateNewQuestion()
                }
            }
        } catch {
            print("Error fetching countries: \(error)")
        }
    }

    func generateNewQuestion() {
        guard !countries.isEmpty else { return }

        let availableCountries = countries.filter { !usedCountries.contains($0.id) }
        guard !availableCountries.isEmpty else {
            isGameOver = true
            return
        }

        let correctCountry = availableCountries.randomElement()!
        usedCountries.insert(correctCountry.id)

        var options = [correctCountry]
        while options.count < 3 {
            if let randomCountry = countries.randomElement(),
               !options.contains(where: { $0.id == randomCountry.id })
            {
                options.append(randomCountry)
            }
        }

        options.shuffle()
        let correctAnswerIndex = options.firstIndex(where: { $0.id == correctCountry.id })!

        currentQuestion = Question(
            correctCountry: correctCountry,
            options: options,
            correctAnswerIndex: correctAnswerIndex
        )

        questionCount += 1
    }

    func checkAnswer(_ index: Int) {
        if let question = currentQuestion {
            if index == question.correctAnswerIndex {
                score += 1
            }

            if questionCount == selectedQuestionCount {
                isGameOver = true
            } else {
                generateNewQuestion()
            }
        }
    }

    func resetGame() {
        score = 0
        questionCount = 0
        selectedQuestionCount = nil
        currentQuestion = nil
        isGameOver = false
        usedCountries.removeAll()
    }

    func getPerformanceMessage() -> String {
        guard let totalQuestions = selectedQuestionCount else { return "" }
        let percentage = Double(score) / Double(totalQuestions) * 100

        switch percentage {
        case 0 ..< 25:
            return "Keep practicing!"
        case 25 ..< 50:
            return "Not bad, but you can do better!"
        case 50 ..< 75:
            return "You're getting there!"
        case 75 ..< 90:
            return "Great job!"
        default:
            return "Amazing! You're a flag expert!"
        }
    }
}
