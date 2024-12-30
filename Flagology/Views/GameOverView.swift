import SwiftUI

/// View displayed when the game is completed
struct GameOverView: View {
    /// Reference to the game's ViewModel
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        ZStack {
            Color(red: 1, green: 0.8, blue: 0)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // Display performance message
                Text(viewModel.getPerformanceMessage())
                    .font(.title.monospaced())
                    .multilineTextAlignment(.center)

                // Display final score
                Text("Final Score: \(viewModel.score)/\(viewModel.selectedQuestionCount ?? 0)")
                    .font(.title2.monospaced())

                // Play again button
                Button("Play Again 🔄") {
                    viewModel.resetGame()
                }
                .font(.title3.monospaced())
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    GameOverView(viewModel: {
        let viewModel = GameViewModel()
        viewModel.score = 8
        viewModel.selectedQuestionCount = 10
        viewModel.isGameOver = true
        return viewModel
    }())
}
