import Foundation

struct GraphQLRequest: Encodable {
    static func createDiscussionsRequest() -> Self {
        let graphQLQuery = """
        {
          repository(name: "website", owner: "diegolavalle") {
            discussions(first: 100) {
              totalCount
              edges {
                node {
                  url
                  number
                  comments(first: 100) {
                    totalCount
                    edges {
                      node {
                        url
                        author {
                          url
                          login
                        }
                        bodyHTML
                      }
                    }
                  }
                }
              }
            }
          }
        }
        """

        return Self(query: graphQLQuery)
    }

    let query: String

    var asJSON: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
