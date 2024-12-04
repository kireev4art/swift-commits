import Swift


enum Source: String {
    case github = "GitHub API"
    case swiftData = "SwiftData"
}


extension Source: CaseIterable {}


extension Source: Identifiable {
    var id: Self { self }
}


extension Source: CustomStringConvertible {
    var description: String { rawValue }
}
