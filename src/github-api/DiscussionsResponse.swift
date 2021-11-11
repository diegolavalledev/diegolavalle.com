struct DiscussionsResponse: Decodable {
    struct Data: Decodable {
        struct Repository: Decodable {
            struct Discussions: Decodable {
                struct Edge: Decodable {
                    struct Node: Decodable {
                        struct Comments: Decodable {
                            struct Edge: Decodable {
                                struct Node: Decodable {
                                    struct Author: Decodable {
                                        let url: String
                                        let login: String
                                    }
                                    struct Replies: Decodable {
                                        let totalCount: Int
                                    }
                                    let url: String
                                    let author: Author
                                    let bodyHTML: String
                                    let replies: Replies
                                }
                                let node: Node
                            }
                            let totalCount: Int
                            let edges: [Edge]
                        }
                        let url: String
                        let number: Int
                        let comments: Comments
                    }
                    let node: Node
                }
                let totalCount: Int
                let edges: [Edge]
            }
            let discussions: Discussions
        }
        let repository: Repository
    }
    let data: Data
}
