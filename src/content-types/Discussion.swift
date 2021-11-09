import SwiftySites

struct Discussion: Content, Encodable {
    let path: String
    let id: Int
    let comments: [String]
}
