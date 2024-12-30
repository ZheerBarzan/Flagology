import SwiftUI

/// View for selecting the number of questions to play
struct QuestionSelectionView: View {
    /// Reference to the game's ViewModel
    @ObservedObject var viewModel: GameViewModel
    /// Available options for number of questions
    let questionOptions = [10, 50, 100, -1]

    var body: some View {
        ZStack {
            Color(red: 1, green: 0.8, blue: 0).ignoresSafeArea()
            VStack(spacing: 20) {
                Image("flagology").resizable().scaledToFit()
                    .frame(width: 200, height: 200)
                    .shadow(radius: 10)
                Text("Geography if it was Fun!")
                    .font(.headline.monospaced())
                    .fontWeight(.bold)
                    .foregroundColor(.black)


                Text("How many countries do you want to guess?")
                    .font(.title2.monospaced())
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
                            .font(.title3.monospaced())
                            .frame(maxWidth: 200)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    QuestionSelectionView(viewModel: GameViewModel())
}
