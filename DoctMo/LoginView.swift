import SwiftUI

struct LoginView: View {
    var onLogin: () -> Void

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("DoctMo").font(.largeTitle).bold()
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("Login") {
                onLogin()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
