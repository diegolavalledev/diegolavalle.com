let post_20221129_calling_mutating_async_functions = Post("/posts/2022-11-29-calling-mutating-async-functions", "Calling Mutating Async Functions from SwiftUI Views", .none, "DL", "2022-11-29T12:00:00Z", (.swiftUI, .swiftConcurrency), ["Async/Await", "Swift", "iOS", "macOS"], discussion: 7) { """

Whenever we try to make a call from a SwiftUI view to a mutating asynchronous function on a struct, we are greeted with an error message similar to this one:

`Cannot call mutating async function 'someFunction()' on actor-isolated property 'someStruct'.`

Let's assume we have the following data structure design which allows us to unlock an app with a three second delay:

```swift
import Combine

@MainActor
class AppData: ObservableObject {
    @Published var status: AppStatus = AppStatus()
}

struct AppStatus {
    private(set) var isLocked = true
    
    mutating func unlock() async
    {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        isLocked = false
    }
}
```

Now suppose we want to call the async mutating function `unlock()` from a SwiftUI view:

```swift
import SwiftUI

struct ContentView: View {
    
    @StateObject var appData = AppData()
    @State var unlocking = false
    
    var body: some View {
        VStack {
            if appData.status.isLocked {
                Text("Content is locked.")
                Button("Tap here to unlock") { Task {
                    unlocking = true
                    await appData.status.unlock() // Error: Cannot call mutating async function 'unlock()' on actor-isolated property 'appData'.
                } }
                .disabled(unlocking)
            } else {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
        }
        .padding()
    }
}
```

As it is, we'll get the familiar error: `Cannot call mutating async function 'unlock()' on actor-isolated property 'appData'.`


To work around this issue we can simply add a _proxy_ function to our `struct`'s `Binding` type which will in turn call the original mutating function. It's important that we mark this extension `@MainActor` to avoid the infamous _purple_ error reminding us that _publishing changes from background threads is not allowed_.

```swift
import SwiftUI

@MainActor
extension Binding where Value == AppStatus {

    func unlock() async {
        await wrappedValue.unlock()
    }
}

```

Now we can simply modify the original call site and add a `$` sign to `appData` to access the binding and call our proxy.

```swift
…
Button("Tap here to unlock") { Task {
    unlocking = true
    await $appData.status.unlock() // No longer gives error.
} }
…
```

This technique allows us to continue to leverage value types and incorporate even more sophisticated logic into our models.

""" } summary: { """
Work around calling mutating asynchronous functions on actor-isolated properties by the way of bindings.
""" }
