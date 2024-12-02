import SwiftUI


struct CommitView: View {

    let commit: Commit

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: commit.avatar) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(.circle)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .frame(width: imageScale, height: imageScale)
                Text(commit.author)
                    .font(.title2)
            }
            Text(commit.message)
        }
    }

    @ScaledMetric(relativeTo: .title2) var imageScale: CGFloat = 30

}


#Preview {
    CommitView(commit: .init(
        sha: "sha",
        message: "message\n\nmore",
        author: "author",
        avatar: URL(string: "https://thispersondoesnotexist.com")!)
    )
}
