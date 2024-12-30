import Foundation

/// ViewModel that manages the flag guessing game logic
class GameViewModel: ObservableObject {
    /// Array of all available countries
    @Published var countries: [Country] = []
    /// Current question being displayed to the user
    @Published var currentQuestion: Question?
    /// Current score of the player
    @Published var score = 0
    /// Number of questions answered
    @Published var questionCount = 0
    /// Total number of questions selected by the user
    @Published var selectedQuestionCount: Int?
    /// Indicates if the game is over
    @Published var isGameOver = false

    /// Set of countries that have already been used in questions
    private var usedCountries: Set<String> = []

    /// Structure representing a single question in the game
    struct Question {
        /// The country that needs to be identified
        let correctCountry: Country
        /// Array of countries shown as options (including the correct one)
        let options: [Country]
        /// Index of the correct country in the options array
        let correctAnswerIndex: Int
    }

    /// Fetches countries from the REST Countries API
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

    /// Generates a new question with random country options
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

    /// Checks if the user's answer is correct and updates the game state
    /// - Parameter index: The index of the selected answer
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

    /// Resets the game state to initial values
    func resetGame() {
        score = 0
        questionCount = 0
        selectedQuestionCount = nil
        currentQuestion = nil
        isGameOver = false
        usedCountries.removeAll()
    }

    /// Generates a performance message based on the final score
    /// - Returns: A string containing the performance message
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
