import Observation
import Foundation
import OpenAPIURLSession
import GithubAPI


@Observable
final class SwiftCommitsModel {

    var source: Source = .github

    var commits: [Commit] = []

    private(set) var isLoading: Bool = false

    var bottomText: String {
        if isLoading {
            "Loading..."
        } else {
            "No more commits"
        }
    }

    func footer(isVisible: Bool) {
        guard isVisible, !isLoading, source == .github else { return }
        Task {
            isLoading = true
            defer { isLoading = false }
            await loadNextPage()
        }
    }


    // MARK: - private

    private var page: Int = 0

    private func loadNextPage() async {
        defer { page += 1 }
        let client = Client(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport())
        let response = try! await client.repos_sol_list_hyphen_commits(path: .init(owner: "swiftlang", repo: "swift"), query: .init(per_page: 10, page: page))
        let json = try! response.ok.body.json
        commits.append(contentsOf: json.map {
            let sha = $0.sha
            let message = $0.commit.message
            let author = $0.commit.author?.name ?? "Unknown author"
            let avatar: URL?
            switch $0.author {
            case .simple_hyphen_user(let object):
                avatar = URL(string: object.avatar_url)
            default:
                avatar = nil
            }
            return .init(sha: sha, message: message, author: author, avatar: avatar)
        })
    }

}
