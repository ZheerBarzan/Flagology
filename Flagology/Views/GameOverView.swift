import SwiftUI

/// View displayed when the game is completed
struct GameOverView: View {
    /// Reference to the game's ViewModel
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 20) {
            // Display performance message
            Text(viewModel.getPerformanceMessage())
                .font(.title)
                .multilineTextAlignment(.center)

            // Display final score
            Text("Final Score: \(viewModel.score)/\(viewModel.questionCount)")
                .font(.title2)

            // Play again button
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
