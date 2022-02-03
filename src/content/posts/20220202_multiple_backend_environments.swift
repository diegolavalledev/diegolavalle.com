let post_20220202_multiple_backend_environments = Post("/posts/2022-02-02-multiple-backend-environments", "Multiple Backend Environments", .none, "DL", "2022-02-02T12:00:00Z", (.xcode, .devOps), ["Xcode Build System", "Swift", "iOS", "macOS"], discussion: 6) { """

In this article we are going to discuss the solution implemented by the Discussions [sample app](https://github.com/diegolavalle/website-examples/blob/release/DiscussionsApp/DiscussionsApp/DiscussionsApp.swift) written with SwiftUI. The app was created for the single purpose of devising a practical yet powerful mechanism for controlling which API environment the data will be loaded from.

# Sample app functionality

Discussions fetches the comments made to this post over the network and displays the total on screen. The footer tells us which specific endpoint this information is being retrieved from.

![Discussions App](DiscussionsApp.jpg)

# Network settings

We will specify the API endpoint as part of a `NetworkSettings` type which serves as a descriptor format.

```swift
import Foundation

struct NetworkSettings {

    enum Environments {
        static let production = NetworkSettings(
            discussionsURL: URL(string: "https://data.diegolavalle.com/discussion/6.json")!
        )

        static let testing = NetworkSettings(
            discussionsURL: URL(string: "http://localhost:8080/discussion/6.json")!
        )

        static let local = NetworkSettings(
            discussionsURL: Bundle.main.url(forResource: "discussion", withExtension: "json5")!
        )
    }

    let discussionsURL: URL
}
```

This allows us to group the sets of URLs which conform the different backend environments. The available environments are:

- **Production** - Points to a HTTPS host online.
- **Testing** - Uses localhost as endpoint (requires running an instance of the service locally).
- **Local** - Uses a bundled JSON 5 file as data source.

![Discussions App Local](DiscussionsAppLocal.jpg)

# Controlling the environment

The primary way in which we will control the API endpoint is through an environment _variable_ in the scheme. By creating a scheme for each backend we can easily launch the app with the desired setting.

![Schemes](Schemes.png)

To keep the setting in between app launches we will simply save its value in app storage – a.k.a. user defaults – and this will also allow us to test while detached from Xcode.

```swift
@main
struct DiscussionsApp: App {

    init() {
        // Cache the environment variable in app storage (user defaults).
        if let networkSettings = ProcessInfo.processInfo.environment["NETWORK_SETTINGS"] {
            UserDefaults.standard.set(networkSettings, forKey: "networkSettings")
        }
    }

    @StateObject var dataStore = DataStore()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dataStore)
        }
    }
}
```

A basic settings bundle can give developers and QA engineers more control by allowing them to change the environment on-the-fly.

![Discussions App Settings](DiscussionsAppSettings.jpg)

# Default environment

To make things more interesting we are going to define different environment settings for each of the standard build configurations. `Release` – which is use for archiving and distribution – will obviously hit production servers. `Debug` on the other hand will point the app to the testing version of our API.

![Build Settings](BuildSettings.png)

```swift
extension NetworkSettings {

    init() {
        let defaultEnvironment = Bundle.main.object(forInfoDictionaryKey: "DEFAULT_NETWORK_SETTINGS") as? String
        let storedEnvironment = UserDefaults.standard.value(forKey: "networkSettings") as? String
        let resolvedEnvironment = storedEnvironment ?? defaultEnvironment

        switch resolvedEnvironment {
        case "testing":
            self = Environments.testing
        case "local":
            self = Environments.local
        default:
            self = Environments.production
        }
    }
}
```

Note that this does not require to replicate or create non-standard configurations or targets, nor it utilizes Xcode configuration files. We simply achieve this functionality by adding a user-defined value to our project's build settings which we will later pick up from the information property list (`Info.plist`).

![Info Property List](InfoPlist.png)

# Conclusion

This way our solution is complete leaving us with a great tool that does not sacrifice any other aspects of our developer experience.

Let me know in the comments whether you were able to implement this technique in your own project.

""" } summary: { """
Set up your iOS app to target different API environments with minimal project configuration.
""" }
