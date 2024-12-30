import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color(red: 1, green: 0.8, blue: 0)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image("flagology")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .shadow(radius: 10)

                Text("FLAGOLOGY")
                    .font(.largeTitle.monospaced())
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
