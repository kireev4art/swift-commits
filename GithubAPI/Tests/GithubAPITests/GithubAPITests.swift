import Testing
import Foundation
import GithubAPI
import OpenAPIURLSession


@Test func generatedCodeIsPublic() async throws {
    let _ = Client(serverURL: try Servers.Server1.url(), transport: URLSessionTransport())
}


@Test func generatedTypeIsCorrect() async throws {
    let url = Bundle.module.url(forResource: "Resources/swiftlang.commits", withExtension: "json")!
    let data = try Data(contentsOf: url)
    typealias Commits = [Components.Schemas.commit]
    let commits = try JSONDecoder().decode(Commits.self, from: data)
    #expect(commits.count == 10)
    #expect(commits.first?.sha == "a3075da13cb9ef778c14d6ca537c1c83503d96af")
    #expect(commits.first?.commit.message == "Gardening: Remove out-of-date comments from availability-macros.def.")
}
