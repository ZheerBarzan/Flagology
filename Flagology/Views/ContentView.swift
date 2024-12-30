import SwiftUI

struct ContentView: View {
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
