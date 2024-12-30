import SwiftUI

/// Root view that manages the navigation between different game states
struct ContentView: View {
    /// ViewModel that manages the game state
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        if viewModel.selectedQuestionCount == nil {
            QuestionSelectionView(viewModel: viewModel)
        } else if viewModel.isGameOver {
            GameOverView(viewModel: viewModel)
        } else {
            GameView(viewModel: viewModel)
        }
    }
}
