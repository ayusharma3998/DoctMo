import SwiftUI

struct ProfileView: View {
    var body: some View {
        Form {
            Section(header: Text("User")) {
                Text("Name: Ayush Sharma")
                Text("Email: ayush@example.com")
            }
            Section(header: Text("Settings")) {
                Text("Notifications: On")
            }
        }.navigationTitle("Profile")
    }
}
