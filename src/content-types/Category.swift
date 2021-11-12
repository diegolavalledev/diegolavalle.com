enum Category: String, CaseIterable {
    case swiftServerSide, contentManagement, swiftConcurrency
    
    var name: String {
        switch(self) {
        case .swiftServerSide:
            return "Server-Side Swift"
        case .contentManagement:
            return "Content Management"
        case .swiftConcurrency:
            return "Swift Concurrency"
        }
    }
}
