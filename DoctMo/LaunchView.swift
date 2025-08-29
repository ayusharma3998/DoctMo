import SwiftUI

struct LaunchView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            RootView()
        } else {
            VStack {
                Text("DoctMo")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color("PrimaryGreen"))
                Text("Your Health, Simplified")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
