import SwiftySites

let categories = Category.allCases.map { category in Page("/categories/\(category)", "\(category.name)") { """
    # \(category.name) Category

    Posts on the _\(category.name)_ category.

    """ } }
