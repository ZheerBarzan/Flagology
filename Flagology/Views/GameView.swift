import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 20) {
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
                Text(question.correctCountry.name.common)
                    .font(.title2)

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
