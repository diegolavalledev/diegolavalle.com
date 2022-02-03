let post_20211125_setting_text_field_focus = Post("/posts/2021-11-25-setting-text-field-focus", "Setting a Text Field's Focus on Launch", .none, "DL", "2021-11-25T12:00:00Z", (.swiftUI, .swiftConcurrency), ["SwiftUI", "iOS", "Focus", "TextField", "FocusState", "Task"], discussion: 4) { """

Like so many of us I was waiting for better focus control on SwiftUI. It finally came in the form of the [FocusState](https://developer.apple.com/documentation/swiftui/focusstate) property wrapper which let's us bind a property to an element's focus state.

Let's say we have a form like this one, with one text field and a button.

```swift
import SwiftUI

struct MyForm: View {

    @State var text = ""

    var body: some View {
        Form {
            Section {
                TextField("Text", text: $text)
            } header: {
                Text("Example Text Field")
            }
            Button("Do Nothing") { }
        }
    }
}
```

We would like to control the focus of the text field by pressing the button. For this we need a boolean property wrapped with `@FocusState` which we will bind to the field using the [focused](https://developer.apple.com/documentation/swiftui/view/focused(_:)) view modifier.

```swift
struct MyForm: View {

    @State var text = ""
    @FocusState var focused

    var body: some View {
        Form {
            Section {
                TextField("Text", text: $text)
                .focused($focused)
            } …
        }
    }
}
```

We can now use the button to toggle the focus state of the text field.

```swift
Button("Toggle Text Field Focus") {
    focused.toggle()
}
```

But what if we want to set the focus on the text field at launch. This seems to be the [default behavior](https://developer.apple.com/documentation/swiftui/view/prefersdefaultfocus(_:in:)) on macOS but not on iOS.

In the pass we would have probably attempted to do something with `onAppear(perform:)` but new in iOS 15 is the [task](https://developer.apple.com/documentation/swiftui/view/task(priority:_:)) modifier which taps into Swift's new concurrency capabilities. Unfortunately what should be rather straightforward is not really working as of Xcode 13.1. Bummer.

```swift
TextField("Text", text: $text)
.task {
    // Not really working 🤷‍♂️
    focused = true
}
```

But not all is lost. Previously we could have attempted the old trick of calling `asyncAfter` on the main dispatch queue and introduce an artificial delay. Today with async/await we can apply the equally nasty hack with a little more conciseness using `Task.sleep`.

```swift
TextField("Text", text: $text)
.task {
    await Task.sleep(100_000_000)
    focused = true
}
```

That code achieves what we want although the hard-coded nanosecond value leaves the question whether this threshold will always be the same regardless of device and runtime conditions.

For now the final solution just works and our little test form is complete.

```swift
struct MyForm: View {

    @State var text = ""
    @FocusState var focused

    var body: some View {
        Form {
            Section {
                TextField("Text", text: $text)
                .focused($focused)
                .task {
                    await Task.sleep(100_000_000)
                    focused = true
                }
            } header: {
                Text("Example Text Field")
            } footer: {
                Text("Focus _should_ be set on launch.")
            }
            Button("Toggle Text Field Focus") {
                focused.toggle()
            }
        }
    }
}
```

Are there better solutions to work around what seems to be a [bug](https://developer.apple.com/forums/thread/681962) on Apple's side? Leave a comment in the discussion area and tell me what you think.

![Demo](demo.gif)

""" } summary: { "Leverage one of SwiftUI's latest features to automatically set the focus of a text field as soon as it appears." }
