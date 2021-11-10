import SwiftySites

func makeDiscussionsGenerator(discussions: [Discussion]) -> Site.Generator {
    Site.generatorA { _ in
        discussions
   }
}
