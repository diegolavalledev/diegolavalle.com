import SwiftySites

let discussionsGenerator = Site.generatorA { site in
    [
        Discussion(path: "/discussion/1", id: 1, comments: [
            "This is a comment.",
            "I am a different comment."
        ]),
        Discussion(path: "/discussion/2", id: 2, comments: [
            "First comment for discussion #2.",
            "Second comment of second discussion."
        ])
    ]
}
