
import Foundation

struct Answer : Codable {
    var status: String?
    var totalResults: Int
    var articles: [Article]
}
