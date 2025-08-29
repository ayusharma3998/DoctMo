import Foundation

class APIClient {
    static let shared = APIClient()
    private init() {}

    var baseURL = URL(string: "http://localhost:8080")!

    func get<T: Decodable>(_ path: String) async throws -> T {
        let url = baseURL.appendingPathComponent(path)
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func postJSON<T: Decodable, B: Encodable>(_ path: String, body: B) async throws -> T {
        var req = URLRequest(url: baseURL.appendingPathComponent(path))
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONEncoder().encode(body)
        let (data, resp) = try await URLSession.shared.data(for: req)
        guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func uploadReport(patientId: Int64, labName: String, type: String, fileURL: URL) async throws -> ReportDTO {
        var req = URLRequest(url: baseURL.appendingPathComponent("/api/reports"))
        req.httpMethod = "POST"
        let boundary = UUID().uuidString
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()
        func append(_ string: String) { data.append(string.data(using: .utf8)!) }

        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"patientId\"\r\n\r\n\(patientId)\r\n")
        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"labName\"\r\n\r\n\(labName)\r\n")
        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"type\"\r\n\r\n\(type)\r\n")

        let fileData = try Data(contentsOf: fileURL)
        append("--\(boundary)\r\n")
        append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileURL.lastPathComponent)\"\r\n")
        append("Content-Type: application/octet-stream\r\n\r\n")
        data.append(fileData)
        append("\r\n--\(boundary)--\r\n")

        let (respData, resp) = try await URLSession.shared.upload(for: req, from: data)
        guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(ReportDTO.self, from: respData)
    }
}
