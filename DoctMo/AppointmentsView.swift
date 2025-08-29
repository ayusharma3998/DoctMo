import SwiftUI

struct AppointmentsView: View {
    @State private var items: [AppointmentDTO] = []

    var body: some View {
        List(items) { a in
            VStack(alignment: .leading) {
                Text(a.doctor.user.name).font(.headline)
                Text(a.time).font(.subheadline)
                Text("\(a.mode) • \(a.status)")
            }
        }
        .navigationTitle("Appointments")
        .task { await fetch() }
    }

    func fetch() async {
        do {
            let result: [AppointmentDTO] = try await APIClient.shared.get("/api/appointments/patient/1")
            await MainActor.run { self.items = result }
        } catch {
            print(error)
        }
    }
}
