import SwiftySites

let categoriesGenerator = Site.generatorA { site in
    Category.allCases.map { category in Page("/categories/\(category)", "\(category.name)") { """
    # \(category.name) Category

    Posts on the _\(category.name)_ category.

    """ } }
}
