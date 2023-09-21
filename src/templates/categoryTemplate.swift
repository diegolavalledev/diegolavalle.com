import SwiftySites

let categoryTemplate = Template(#//categories/[\W\w]+/#) { (page: Page) in baseLayout(page: page, main: """
<main class="category">
    <div>\(page.content)</div>
    <div>
        <a href="/categories">All categories</a>
    </div>
    <br />
    <section>
        \(posts
            .filter { $0.categories.0 == page.category || $0.categories.1 == page.category }
            .sorted(by: Post.dateDescendingOrder).enumerated().map { """
                \(summaryPartial($1))
                \($0 < posts.count - 1 ? "<hr />" : "")
            """ }
            .joined()
        )
    </section>
</main>
""" ) }
