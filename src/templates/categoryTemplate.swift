let categoryTemplate = Site.templateA(#"/categories/[\W\w]+"#) { site, page in baseLayout(site: site, page: page, main: """
<main class="category">
    <div>\(page.content)</div>
    <div>
        <a href="/categories">All categories</a>
    </div>
    <br />
    <section>
        \(site.contentB
            .filter { $0.categories.0 == page.category || $0.categories.1 == page.category }
            .sorted(by: Post.dateDescendingOrder).enumerated().map { """
                \(summaryPartial(site, $1))
                \($0 < site.contentB.count - 1 ? "<hr />" : "")
            """ }
            .joined()
        )
    </section>
</main>
""" ) }
