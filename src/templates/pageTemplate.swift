import Foundation

let discussionTemplate = Site.templateA(index: "", suffix: "json") { site, discussion in
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    guard let data = try? encoder.encode(discussion), let json = String(data: data, encoding: .utf8) else {
        fatalError()
    }
    return json
}
