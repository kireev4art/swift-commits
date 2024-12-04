import SwiftUI


struct CommitView: View {

    let commit: Commit

    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AuthorAsyncImage(url: commit.avatar)
                    .frame(width: imageScale, height: imageScale)
                Text(commit.author)
                    .font(.title2)
            }
            Text(commit.message)
        }
    }

    @ScaledMetric(relativeTo: .title2)
    private var imageScale: CGFloat = 30

}


#Preview {
    CommitView(commit: .init(
        sha: "sha",
        message: "message\n\nmore",
        author: "author",
        avatar: URL(string: "https://thispersondoesnotexist.com")!)
    )
}
