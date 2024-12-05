import Foundation
import SwiftData


@Model
final class CommitModel {

    init(sha: String, message: String, author: String, avatar: URL? = nil) {
        self.sha = sha
        self.message = message
        self.author = author
        self.avatar = avatar
    }

    @Attribute(.unique)
    var sha: String

    var message: String

    var author: String

    var avatar: URL?

}
