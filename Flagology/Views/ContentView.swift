import SwiftUI

/// Root view that manages the navigation between different game states
struct ContentView: View {
    /// ViewModel that manages the game state
    @StateObject private var gameViewModel = GameViewModel()
    @State private var isShowingLaunchScreen = true

    var body: some View {
        ZStack {
            if isShowingLaunchScreen {
                LaunchScreenView()
            } else {
                if gameViewModel.selectedQuestionCount == nil {
                    QuestionSelectionView(viewModel: gameViewModel)
                } else if gameViewModel.isGameOver {
                    GameOverView(viewModel: gameViewModel)
                } else {
                    GameView(viewModel: gameViewModel)
                }
            }
        }
        .onAppear {
            // Show launch screen for 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isShowingLaunchScreen = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
