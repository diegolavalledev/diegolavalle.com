let post_20210904_supporting_markdown = Post("/posts/2021-09-04-supporting-markdown", "Supporting Markdown on SwiftySites", .none, "DL", "2021-05-10T12:00:00Z", (.swiftServerSide, .contentManagement), ["SwiftySites", "Markdown", "Swift", "Linux"]) { #"""
One of the first challenges one encounters when building a static site generator is Markdown support.

I knew Apple had just [announced](https://developer.apple.com/videos/play/wwdc2021/10109/?time=486) during WWDC21 support for Markdown in attributed strings and other APIs but offered no interface for directly converting Markdown to HTML.

A bit of digging in the developer forums led me to [this answer](https://developer.apple.com/forums/thread/682711) by an Apple engineer. Now I knew for a fact that internally they were using the fantastic [cmark-gfm](https://github.com/github/cmark-gfm) library.

`cmark-gfm` itself is a fork of the [cmark](https://github.com/commonmark/cmark) C library. GFM stands for [GitHub Flavor Markdown](https://github.github.com/gfm/) and consists of a set of extensions to the [CommonMark](https://commonmark.org) specification.

Having some experience in integrating C code into Swift applications I started adapting `cmark-gfm` for my purposes. The endeavour involved cross-compiling for the relevant architectures and linking to a custom Objective-C framework.

Since `cmark-gfm` lacked a simplified interface for straightforwardly converting GFM to HTML – which the original `cmark` had – I decided to write my own Swift protocol around it. I decided to expose all the options and extensions available from the underlying libraries.

While the whole effort was [open-source](https://github.com/swiftysites/cmark-gfm) I decided to publish the final result as a binary XCFramework. This makes it really easy to include – via Swift Package Manager (SPM) – in SwiftySites or any other project that needs it without the hassle of having to build everything from C sources.
"""# } summary: { """
Generate HTML from Markdown integrating one of the most popular libraries.
""" }
