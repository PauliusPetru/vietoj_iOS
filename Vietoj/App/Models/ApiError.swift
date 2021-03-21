import Foundation

struct ApiError: Codable {
    let success: Bool
    let error: String
}
