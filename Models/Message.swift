import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var sender: String
    var text: String
    var received: Bool
    var timestamp: Date
}
