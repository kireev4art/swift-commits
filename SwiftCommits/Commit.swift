import Foundation


struct Commit {

    let sha: String

    let message: String

    let author: String

    let avatar: URL?

}


extension Commit: Identifiable {

    var id: String {
        sha
    }

}
