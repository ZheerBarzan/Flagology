import SwiftUI

/// View that displays the main game interface
struct GameView: View {
    /// Reference to the game's ViewModel
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 20) {
            // Score and reset button
            HStack {
                Text("Score: \(viewModel.score)/\(viewModel.questionCount)")
                    .font(.headline)

                Spacer()

                Button("Reset") {
                    viewModel.resetGame()
                }
            }
            .padding(.horizontal)

            Text("Guess the Flag")
                .font(.title)

            if let question = viewModel.currentQuestion {
                // Display country name to guess
                Text(question.correctCountry.name.common)
                    .font(.title2)

                // Display flag options
                VStack(spacing: 15) {
                    ForEach(0 ..< 3) { index in
                        AsyncImage(url: URL(string: question.options[index].flags.png)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            viewModel.checkAnswer(index)
                        }
                    }
                }
            }
        }
        .padding()
    }
}
