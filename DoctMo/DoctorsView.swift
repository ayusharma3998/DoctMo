import SwiftUI

struct DoctorsView: View {
    @State private var doctors: [DoctorDTO] = []
    @State private var query = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search specialization", text: $query)
                        .textFieldStyle(.roundedBorder)
                    Button("Go") { Task { await fetch() } }
                        .buttonStyle(.bordered)
                }.padding(.horizontal)

                List(doctors) { doc in
                    NavigationLink(destination: DoctorDetailView(doctor: doc)) {
                        VStack(alignment: .leading) {
                            Text(doc.user.name).font(.headline)
                            Text("\(doc.specialization) • \(doc.experienceYears) yrs • \(doc.clinicAddress)")
                                .font(.subheadline)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Doctors")
            .task { await fetch() }
        }
    }

    func fetch() async {
        do {
            let path = query.isEmpty ? "/api/doctors" : "/api/doctors?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
            let result: [DoctorDTO] = try await APIClient.shared.get(path)
            await MainActor.run { self.doctors = result }
        } catch {
            print("Failed: \(error)")
        }
    }
}
