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
                                    let url: String
                                    let author: Author
                                    let bodyHTML: String
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


/*
{
"data": {
 "repository": {
   "discussions": {
     "edges": [
       {
         "cursor": "Y3Vyc29yOnYyOpK5MjAyMS0xMC0yOFQyMDo1MDozNyswMTowMM4AN7IX",
         "node": {
           "url": "https://github.com/diegolavalle/website/discussions/1",
           "number": 1,
           "comments": {
             "edges": [
               {
                 "cursor": "Y3Vyc29yOnYyOpK5MjAyMS0xMC0yOFQyMDozMToyNiswMTowMM4AF7qF",
                 "node": {
                   "url": "https://github.com/diegolavalle/website/discussions/1#discussioncomment-1555077",
                   "author": {
                     "url": "https://github.com/develoco",
                     "login": "develoco"
                   },
                   "body": "That's fantastic. Apple themselves have praised the GFM library 💪 Have you checked their new [Swift Markdown](https://github.com/apple/swift-markdown) repo?? 😅 Looks about the same although I'm not sure whether it uses GFM under the hood or if it supports Linux 🤷‍♂️ Cheers! 👋"
                 }
               }
             ]
           }
         }
       }
     ]
   }
 }
}
}
*/
