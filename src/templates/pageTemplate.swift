import Foundation
import SwiftySites

let discussionTemplate = Template(index: "", suffix: "json") { (discussion: Discussion) in
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    guard let data = try? encoder.encode(discussion), let json = String(data: data, encoding: .utf8) else {
        fatalError()
    }
    return json
}
