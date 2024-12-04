import GithubAPI
import OpenAPIURLSession
import OSLog


private let logger: Logger = .init(subsystem: "SwiftCommits", category: "GithubCommitsFetcher")


enum CommitsFetchingError: Error {
    case sendingRequest(any Error)

    case decodingResponse(DecodingResponseError)
    struct DecodingResponseError: Error {
        let title: String
        let details: String?
    }
}


protocol CommitsFetching: Actor {

    func fetchCommits(owner: String, repo: String, perPage: Int, page: Int) async throws(CommitsFetchingError) -> [Commit]

}


actor GithubCommitsFetcher {

    init(client: Client = .init(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport())) {
        self.client = client
    }

    let client: Client

}


extension GithubCommitsFetcher: CommitsFetching {

    func fetchCommits(owner: String, repo: String, perPage: Int, page: Int) async throws(CommitsFetchingError) -> [Commit] {
        let response = try await sendRequest(owner: owner, repo: repo, perPage: perPage, page: page)
        let commits = try decodeResponse(response)
        return commits
    }


    // MARK: explicitly internal

    internal func sendRequest(owner: String, repo: String, perPage: Int, page: Int) async throws(CommitsFetchingError) -> Operations.repos_sol_list_hyphen_commits.Output {
        do {
            return try await client.repos_sol_list_hyphen_commits(
                path: .init(owner: owner, repo: repo),
                query: .init(per_page: perPage, page: page)
            )
        } catch let error {
            logger.error("Send request failed: \(error.localizedDescription)")
            throw .sendingRequest(error)
        }
    }

    internal func decodeResponse(_ response: Operations.repos_sol_list_hyphen_commits.Output) throws(CommitsFetchingError) -> [Commit] {
        switch response {
        case .badRequest(let badRequest):
            let title = "Bad Request"
            let details = (try? badRequest.body.json)?.message
            throw .decodingResponse(.init(title: title, details: details))
        case .conflict(let conflict):
            let title = "Conflict"
            let details = (try? conflict.body.json)?.message
            throw .decodingResponse(.init(title: title, details: details))
        case .internalServerError(let internalServerError):
            let title = "Internal Server Error"
            let details = (try? internalServerError.body.json)?.message
            throw .decodingResponse(.init(title: title, details: details))
        case .notFound(let notFound):
            let title = "Not Found"
            let details = (try? notFound.body.json)?.message
            throw .decodingResponse(.init(title: title, details: details))
        case .ok(let ok):
            guard let json = try? ok.body.json else {
                let title = "Invalid Server Response"
                throw .decodingResponse(.init(title: title, details: nil))
            }
            let commits = json.map { Commit(from: $0) }
            return commits
        case .undocumented(statusCode: let statusCode, _):
            let title = "\(statusCode)"
            throw .decodingResponse(.init(title: title, details: nil))
        }
    }

}


extension Commit {

    init(from json: Components.Schemas.commit) {
        self.sha = json.sha
        self.message = json.commit.message

        let unknownAuthor = "Unknown Author"
        if let commitAuthor = json.commit.author {
            self.author = commitAuthor.name ?? commitAuthor.email ?? unknownAuthor
        } else {
            self.author = unknownAuthor
        }

        if let author = json.author, case .simple_hyphen_user(let user) = author {
            self.avatar = URL(string: user.avatar_url)
        } else {
            self.avatar = nil
        }
    }

}
