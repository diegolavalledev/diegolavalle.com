enum Category: String, CaseIterable {
    case swiftUI, swiftServerSide, contentManagement, swiftConcurrency, xcode, devOps
    
    var name: String {
        switch(self) {
        case .swiftUI:
            return "SwiftUI"
        case .swiftServerSide:
            return "Server-Side Swift"
        case .contentManagement:
            return "Content Management"
        case .swiftConcurrency:
            return "Swift Concurrency"
        case .xcode:
            return "Xcode"
        case .devOps:
            return "DevOps"
        }
    }
}
