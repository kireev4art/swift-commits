import Observation
import Foundation
import OpenAPIURLSession
import GithubAPI


@MainActor
@Observable
final class GithubCommitsModel {

    let fetcher: any CommitsFetching = GithubCommitsFetcher()

    private(set) var commits: [Commit] = []

    private(set) var isLoading: Bool = false

    var footer: String {
        if isLoading {
            "Loading..."
        } else {
            "No more commits"
        }
    }

    func footer(isVisible: Bool) {
        guard isVisible, !isLoading else { return }
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
        do {
            let new = try await fetcher.fetchCommits(owner: "swiftlang", repo: "swift", perPage: 30, page: page)
            commits.append(contentsOf: new)
        } catch let error {
            fatalError("\(error)")
        }
    }

}
