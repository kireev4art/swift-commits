import SwiftUI


struct CommitView: View {

    let commit: Commit

    var body: some View {
        VStack(alignment: .leading) {
            AuthorLabel(name: commit.author, avatar: commit.avatar)
            Text(commit.message)
        }
    }

}


#Preview {
    CommitView(commit: .init(
        sha: "sha",
        message: "message\n\nmore",
        author: "author",
        avatar: URL(string: "https://thispersondoesnotexist.com")!)
    )
}
