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
        \(post.discussionID != .none
            ? """
            <script>
                window.currentDiscussionID = \(post.discussionID!)
            </script>
            <hr />
            <section class="comments">
                <p><a href="https://github.com/diegolavalle/website/discussions/\(post.discussionID!)">Add a comment</a>
                </p>
                <div id="comments-app">
                    <div v-if="discussion == null">
                        <em>Loading comments…</em>
                    </div>
                    <div v-if="discussion != null">
                        <div class="comment" v-for="comment in discussion.comments">
                            <div v-html="comment.bodyHTML"></div>
                            <p>
                                <a v-bind:href="comment.authorURL">{{ comment.author }}</a>
                                <span> | </span>
                                <a v-bind:href="comment.url">
                                    <span v-if="comment.totalReplies == 0">
                                        Add a reply
                                    </span>
                                    <span v-if="comment.totalReplies == 1">
                                        {{ comment.totalReplies }} reply
                                    </span>
                                    <span v-if="comment.totalReplies > 1">
                                        {{ comment.totalReplies }} replies
                                    </span>
                                </a>
                            </p>
                        </div>
                        <p>
                            <span v-if="discussion.totalComments == 0">
                                No comments yet.
                            </span>
                            <a v-if="discussion.totalComments > 0" href="https://github.com/diegolavalle/website/discussions/\(post.discussionID!)">See all comments</a>
                        </p>
                    </div>
                </div>
            </section>
            """
            : ""
        )
    </footer>
</article></main>
""" ) }
