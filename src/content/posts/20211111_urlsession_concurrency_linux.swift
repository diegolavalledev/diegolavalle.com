let post_20211111_urlsession_concurrency_linux = Post("/posts/2021-11-11-urlsession-concurrency-linux", "URLSession Concurrency on Linux", .none, "DL", "2021-11-11T12:00:00Z", (.swiftServerSide, .swiftConcurrency), ["Swift", "URLSession", "DataTask", "Async/Await", "Linux"], discussion: 2) { """
Being in the situation of having to write Swift code that runs on both Mac and Linux makes you realize some of the subtle differences between these two.

For instance you can use `URLSession` on the open source toolchain but you need to import `FoundationNetworking` instead of just `Foundation` for it to work.

```swift
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

// Do our thing with URLSession and friends…
```

Now when if comes to language features both implementations of the tool chain should be at par. This includes the new concurrency constructs introduced in Swift 5.5, meaning we can use `async`, `await` and the rest of them.

I decided to test this assertion by writing a tool that fetches comments from the GitHub discussions API which will eventually be rendered under blog posts like this one.

```swift
func fetchComments() async -> [Discussion] {
    // Some actual implementation of this function…
}
```

Effectively the function from the snippet above successfully compiles on both systems without warnings.

Unfortunately this does not extend to the framework's additions which take advantage of the new concurrency features. Take for instance the asynchronous function  [URLSession.data](https://developer.apple.com/documentation/foundation/urlsession/3767353-data) which on macOS just works.

```swift
guard let (data, _) = try? await URLSession.shared.data(for: request) else {
    // Some network error here
}
…
```

The same call on Linux will give us a compiler error since that exact version of the function does not exist yet.

While I couldn't find any DocC-style documentation for the open source version of Foundation, I was able to verify the status of the API on this  [status page](https://github.com/apple/swift-corelibs-foundation/blob/main/Docs/Status.md#entities) where it states that URLSession if _mostly complete_ but that getting tasks and other functions remain unimplemented. This can ultimately be verified in the [source code](https://github.com/apple/swift-corelibs-foundation/blob/release/5.5/Sources/FoundationNetworking/URLSession/URLSession.swift#L420).

So all of this means we have an opportunity to try a different concurrency feature called continuations and combine it with the soon-to-be legacy data task function.

```swift
import FoundationNetworking

func fetchComments() async -> [Discussion] {
    …
    let data: Data = await withCheckedContinuation { continuation in
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                fatalError()
            }
            continuation.resume(returning: data)
        }.resume()
    }
    …
}
```

We can even keep both approaches and apply them conditionally based on our target.

```swift
import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

func fetchComments() async -> [Discussion] {
    …
    #if canImport(FoundationNetworking)
        let data: Data = await withCheckedContinuation { … }
    #else
        guard let response = try? await URLSession.shared.data(for: request) else {… }
        …
    #endif
    …
}
```

The full implementation of the `getComments` function is part of my Website Data project and can be found [here](https://github.com/diegolavalle/website-data/blob/2fd56238638f9ee1eaab51f86061319f3b032982/src/github-api/fetchComments.swift).
""" } summary: { """
The open source Swift toolchain already supports the language's new concurrency features but the Foundation framework has some catching up to do.
""" }
