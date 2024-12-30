import SwiftUI

/// View that displays the main game interface
struct GameView: View {
    /// Reference to the game's ViewModel
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        ZStack {
            Color(red: 1, green: 0.8, blue: 0)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // Score and reset button
                HStack {
                    Text("Score: \(viewModel.score)/\(viewModel.selectedQuestionCount ?? 0)")
                        .font(.headline.monospaced())

                    Spacer()

                    Button(action: viewModel.resetGame) {
                        Image(systemName: "arrow.clockwise")
                            .padding()
                            .font(.title.monospaced())
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                Spacer()

                Text("Guess the Flag 🎯")
                    .font(.title.monospaced())
                Spacer()

                if let question = viewModel.currentQuestion {
                    // Display country name to guess
                    Text(question.correctCountry.name.common)
                        .font(.title2.monospaced())

                    Spacer()

                    // Display flag options
                    VStack(spacing: 15) {
                        ForEach(0 ..< 3) { index in
                            AsyncImage(url: URL(string: question.options[index].flags.png)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 200, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(10)
                            .background(
                                viewModel.showingCorrectAnswer && index == viewModel.correctAnswerIndex
                                    ? Color.black
                                    : Color.clear
                            ).cornerRadius(14)
                            .animation(.easeInOut, value: viewModel.showingCorrectAnswer)
                            .onTapGesture {
                                viewModel.checkAnswer(index)
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    GameView(viewModel: {
        let viewModel = GameViewModel()
        viewModel.selectedQuestionCount = 10
        viewModel.currentQuestion = GameViewModel.Question(
            correctCountry: Country(
                name: Country.Name(common: "United States"),
                flags: Country.Flags(png: "https://flagcdn.com/w320/us.png")
            ),
            options: [
                Country(name: Country.Name(common: "United States"), flags: Country.Flags(png: "https://flagcdn.com/w320/us.png")),
                Country(name: Country.Name(common: "Canada"), flags: Country.Flags(png: "https://flagcdn.com/w320/ca.png")),
                Country(name: Country.Name(common: "Mexico"), flags: Country.Flags(png: "https://flagcdn.com/w320/mx.png")),
            ],
            correctAnswerIndex: 0
        )
        return viewModel
    }())
}
