let post_20211115_automating_swift_site_generation_netlify = Post("/posts/2021-11-15-automating-swift-site-generation-netlify", "Automating Swift Site Generation on Netlify", .none, "DL", "2021-11-15T12:00:00Z", (.swiftServerSide, .contentManagement), ["Swift", "Netlify", "SwiftySites", "Build Pipeline", "Static Site Generation", "Linux"], discussion: 3) { """

Having used GitHub Pages and Jekyll for my hosting needs I eventually switched to Hugo and Netlify. I enjoy the advanced capabilities the latter has to offer such as [branch deploys](https://docs.netlify.com/site-deploys/overview/#branch-deploy-controls) and [branch subdomains](https://docs.netlify.com/domains-https/custom-domains/multiple-domains/#branch-subdomains) both of which I have been taking advantage of extensively.

Recently I decided to move away from Hugo since I'm not truly well-versed in the Go language and so I created a [static site generator](https://github.com/swiftysites/swiftysites) based on Swift. In a nutshell SwiftySites consists of an [SPM package](https://github.com/diegolavalle/website/blob/1c9defbfb17173022adad4cc27870edc453f7e9a/Package.swift) that is added as dependency to an executable target which in turns outputs the website's files.

To produce a local version of the site you simply run the project on Xcode or instead issue `swift run` on the command line. The second alternative is also good for the [open source](https://www.swift.org/download/) version of the compiler which is also available on Linux systems.

If our goal is to generate a production-ready version we should then tweak that command to make sure it picks up the right configuration and also clears the output folder `www` before writing into it again.

```sh
swift run -c release swiftysites --clean
```

So to have Netlify automatically build and publish our site we must provide our custom command in `netlify.toml` at the root of our repository so that we don't get stuck with the default `swift build`. We can optionally specify a preferred version of the toolchain as well.

```toml
[build.environment]
SWIFT_VERSION = "5.5"
[build]
publish = "www"
command = "swift run -c release swiftysites --clean"
```

Check out this very site's [source code](https://github.com/diegolavalle/website) to explore how everything we just discussed ties into the complete solution.

""" } summary: { "Auto-generate and publish your Swift-based static sites." }
