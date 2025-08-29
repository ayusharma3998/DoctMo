import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DoctorsView().tabItem { Label("Doctors", systemImage: "stethoscope") }
            AppointmentsView().tabItem { Label("Appointments", systemImage: "calendar") }
            ReportsView().tabItem { Label("Reports", systemImage: "doc.richtext") }
            ProfileView().tabItem { Label("Profile", systemImage: "person") }
        }
    }
}
