import SwiftUI

struct RootView: View {
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            MainTabView()
        } else {
            LoginView(onLogin: { isLoggedIn = true })
        }
    }
}
