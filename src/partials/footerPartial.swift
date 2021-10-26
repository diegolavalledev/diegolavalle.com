import SwiftySites

let footerPartial = { (site: Site, page: Page?) -> String in """
<footer>
    <details>
        <summary>Made with  and <a href="https://github.com/swiftysites/swiftysites">SwiftySites</a>.</summary>
        <nav>
            <ul>
                \([privacyPage, supportPage, aboutPage].reduce("") {
                    $0 + """
                    <li>\(page?.path == $1.path
                        ? """
                        \($1.title)
                        """
                        : """
                        <a href="\($1.path)">\($1.title)</a>
                        """
                    )</li>
                    """
                })
            </ul>
        </nav>
        <div>\(site.copyright)</div>
    </details>
</footer>
""" }
