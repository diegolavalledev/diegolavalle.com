import Foundation

func fetchComments() async -> [Discussion] {
    guard let token = ProcessInfo.processInfo.environment["GITHUB_API_TOKEN"] else {
        fatalError()
    }
    let url = "https://api.github.com/graphql"

    var request = URLRequest(url: URL(string: url)!)
    request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    request.httpBody = GraphQLRequest.createDiscussionsRequest().asJSON

    guard let (data, _) = try? await URLSession.shared.data(for: request),
          let result = try? JSONDecoder().decode(DiscussionsResponse.self, from: data) else {
        fatalError()
    }
    return result.data.repository.discussions.edges.map(\.node).map(Discussion.init)
}
