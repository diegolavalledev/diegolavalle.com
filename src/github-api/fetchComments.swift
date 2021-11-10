import Foundation

#if canImport(_Concurrency)
    import _Concurrency
#endif

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

func fetchComments() async -> [Discussion] {
    guard let token = ProcessInfo.processInfo.environment["GITHUB_API_TOKEN"] else {
        fatalError()
    }
    let url = "https://api.github.com/graphql"

    var request = URLRequest(url: URL(string: url)!)
    request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    request.httpBody = GraphQLRequest.createDiscussionsRequest().asJSON

    #if canImport(FoundationNetworking)
        let data: Data = await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, _, _ in
                guard let data = data else {
                    fatalError()
                }
                continuation.resume(returning: data)
            }.resume()
        }
    #else
        guard let response = try? await URLSession.shared.data(for: request) else {
            fatalError()
        }
        let data = response.0
    #endif

    guard let result = try? JSONDecoder().decode(DiscussionsResponse.self, from: data) else {
        fatalError()
    }

    return result.data.repository.discussions.edges.map(\.node).map(Discussion.init)
}
