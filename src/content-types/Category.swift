enum Category: String, CaseIterable {
    case swiftUI, swiftServerSide, contentManagement, swiftConcurrency, devOps
    
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
        case .devOps:
            return "DevOps"
        }
    }
}
