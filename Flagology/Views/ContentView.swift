import SwiftUI

/// Root view that manages the navigation between different game states
struct ContentView: View {
    /// ViewModel that manages the game state
    @StateObject private var gameViewModel = GameViewModel()

    var body: some View {
        if gameViewModel.selectedQuestionCount == nil {
            QuestionSelectionView(viewModel: gameViewModel)
        } else if gameViewModel.isGameOver {
            GameOverView(viewModel: gameViewModel)
        } else {
            GameView(viewModel: gameViewModel)
        }
    }
}

#Preview {
    ContentView()
}
