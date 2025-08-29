import Foundation

struct UserDTO: Codable, Identifiable {
    let id: Int64
    let name: String
    let email: String
    let phone: String?
    let role: String
}

struct DoctorDTO: Codable, Identifiable {
    let id: Int64
    let user: UserDTO
    let specialization: String
    let experienceYears: Int
    let clinicAddress: String
}

struct AppointmentDTO: Codable, Identifiable {
    let id: Int64
    let patient: UserDTO
    let doctor: DoctorDTO
    let time: String
    let status: String
    let mode: String
}

struct ReportDTO: Codable, Identifiable {
    let id: Int64
    let patient: UserDTO
    let labName: String
    let type: String
    let filePath: String
    let uploadedAt: String
}
