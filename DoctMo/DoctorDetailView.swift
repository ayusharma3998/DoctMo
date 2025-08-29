import SwiftUI

struct DoctorDetailView: View {
    let doctor: DoctorDTO
    @State private var date = Date().addingTimeInterval(3600)
    @State private var mode = "OFFLINE"

    var body: some View {
        Form {
            Section(header: Text(doctor.user.name)) {
                Text(doctor.specialization)
                Text("Experience: \(doctor.experienceYears) yrs")
                Text("Clinic: \(doctor.clinicAddress)")
            }
            DatePicker("Select time", selection: $date)
            Picker("Mode", selection: $mode) {
                Text("Offline").tag("OFFLINE")
                Text("Online").tag("ONLINE")
            }
            Button("Book Appointment") {
                Task { await book() }
            }
        }.navigationTitle("Book")
    }

    func book() async {
        struct Req: Encodable { let patientId: Int64; let doctorId: Int64; let time: String; let mode: String }
        do {
            let iso = ISO8601DateFormatter()
            iso.formatOptions = [.withInternetDateTime]
            let body = Req(patientId: 1, doctorId: doctor.id, time: iso.string(from: date), mode: mode)
            let _: AppointmentDTO = try await APIClient.shared.postJSON("/api/appointments", body: body)
        } catch {
            print("Booking failed: \(error)")
        }
    }
}
