import SwiftySites

@main
struct SiteGenerator {
    static func main() async {
        let discussions = await fetchComments()
        let site = Site(config,
            content: discussions,
            template: [discussionTemplate])
        site.render(skipSitemap: true)
    }
}
