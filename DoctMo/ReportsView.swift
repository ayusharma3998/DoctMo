import SwiftUI
import UniformTypeIdentifiers

struct ReportsView: View {
    @State private var items: [ReportDTO] = []
    @State private var isImporterPresented = false
    @State private var pickedURL: URL?

    var body: some View {
        VStack {
            List(items) { r in
                VStack(alignment: .leading) {
                    Text("\(r.type) • \(r.labName)")
                    Text(r.uploadedAt).font(.caption)
                }
            }
            HStack {
                Button("Pick File") { isImporterPresented = true }
                    .buttonStyle(.bordered)
                Button("Upload") {
                    Task { await upload() }
                }
                .buttonStyle(.borderedProminent)
                .disabled(pickedURL == nil)
            }.padding()
        }
        .navigationTitle("Reports")
        .task { await fetch() }
        .fileImporter(isPresented: $isImporterPresented, allowedContentTypes: [.pdf, .image]) { result in
            switch result {
            case .success(let url): pickedURL = url
            case .failure(let err): print(err)
            }
        }
    }

    func fetch() async {
        do {
            let result: [ReportDTO] = try await APIClient.shared.get("/api/reports/patient/1")
            await MainActor.run { self.items = result }
        } catch { print(error) }
    }

    func upload() async {
        guard let url = pickedURL else { return }
        do {
            _ = try await APIClient.shared.uploadReport(patientId: 1, labName: "Apollo", type: "Blood Test", fileURL: url)
            await fetch()
        } catch { print("upload failed: \(error)") }
    }
}

extension UTType {
    static var image: UTType { .png }
}
