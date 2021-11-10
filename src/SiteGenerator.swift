@main
struct SiteGenerator {
    static func main() async {
        let discussions = await fetchComments()
        let site = Site(config,
            contentA: [
            ],
            templates: [
                discussionTemplate
            ],
            generators: [
                makeDiscussionsGenerator(discussions: discussions)
            ])
        site.render(skipSitemap: true)
    }
}
