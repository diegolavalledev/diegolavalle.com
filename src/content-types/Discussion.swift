import SwiftySites

struct Discussion: Content, Encodable {
    struct Comment: Encodable{
        let url: String
        let author: String
        let authorURL: String
        let bodyHTML: String
    }
    let path: String
    let url: String
    let number: Int
    let totalComments: Int
    let comments: [Comment]
}

extension Discussion.Comment {
    init(_ node: DiscussionsResponse.Data.Repository.Discussions.Edge.Node.Comments.Edge.Node) {
        self.init(
            url: node.url,
            author: node.author.login,
            authorURL: node.author.url,
            bodyHTML: node.bodyHTML
        )
    }
}

extension Discussion {
    init(_ node: DiscussionsResponse.Data.Repository.Discussions.Edge.Node) {
        self.init(
            path: "/discussion/\(node.number)",
            url: node.url,
            number: node.number,
            totalComments: node.comments.totalCount,
            comments: node.comments.edges.map { .init($0.node) }
        )
    }
}
