let postTemplate = Site.templateB { site, post in baseLayout(site: site, post: post, main: """
<main class="post"><article>
    <header>
        <p class="date">\(post.dateFormatted) • <a href="/categories/\(post.categories.0)">\(post.categories.0.name)</a>, <a href="/categories/\(post.categories.1)">\(post.categories.1.name)</a></p>
        <h1 class="title">
            \(post.title)
            \(
                post.subtitle == .none
                ? ""
                : """
                <br />
                <em>\(post.subtitle!)</em>
                """
            )
        </h1>
        <p class="author">
            <a href="/about">\(post.author)</a>
        </p>
    </header>
    <main>
    \(post.content)
    </main>
    <footer>
        <p class="postTagsSection">
            <span class="postTagsTitle">Tags:</span>
            <span class="postTags">\(post.tags.joined(separator: ", "))</span>
        </p>
        <p class="postDiscussionSection">Leave your comments on this post's <a href="https://github.com/diegolavalle/website/discussions/1"> GitHub Discussion</a>.</span>
        </p>
    </footer>
</article></main>
""" ) }
