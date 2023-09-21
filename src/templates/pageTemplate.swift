import SwiftySites

let pageTemplate = Template(exclude: #/^/categories/[\W\w]+$|/posts|/categories|//#) { (page: Page) in baseLayout(page: page, main: """
<main class="page">\(page.content)</main>
""" ) }
