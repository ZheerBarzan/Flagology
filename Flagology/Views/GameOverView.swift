import SwiftUI

struct GameOverView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.getPerformanceMessage())
                .font(.title)
                .multilineTextAlignment(.center)

            Text("Final Score: \(viewModel.score)/\(viewModel.questionCount)")
                .font(.title2)

            Button("Play Again") {
                viewModel.resetGame()
            }
            .font(.title3)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}


