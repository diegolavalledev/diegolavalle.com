import SwiftySites

let categoriesTemplate = Template(#//categories/#) { (page: Page) in baseLayout(page: page, main: """
<main>
    \(page.content)
    <hr />
    <ul>
        \(Category.allCases.reduce("") {
            $0 + """
            <li>
                <a href="/categories/\($1)">\($1.name)</a>
            </li>
            """
        })
    </ul>
</main>
""" ) }
