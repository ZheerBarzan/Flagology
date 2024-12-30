import SwiftUI

/// View for selecting the number of questions to play
struct QuestionSelectionView: View {
    /// Reference to the game's ViewModel
    @ObservedObject var viewModel: GameViewModel
    /// Available options for number of questions
    let questionOptions = [10, 50, 100, -1]

    var body: some View {
        VStack(spacing: 20) {
            Text("How many countries do you want to guess?")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

            ForEach(questionOptions, id: \.self) { count in
                Button(action: {
                    // -1 represents all countries option
                    viewModel.selectedQuestionCount = count == -1 ? viewModel.countries.count : count
                    Task {
                        await viewModel.fetchCountries()
                    }
                }) {
                    Text(count == -1 ? "All Countries" : "\(count) Countries")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}
