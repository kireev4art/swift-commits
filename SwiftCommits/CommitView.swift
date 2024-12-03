import SwiftUI


struct CommitView: View {

    let commit: Commit

    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: commit.avatar) { phase in
                    switch phase {
                    case .empty:
                        if commit.avatar == nil {
                            Image(systemName: "person.crop.circle.fill")
                        } else {
                            Image(systemName: "progress.indicator")
                                .symbolEffect(.variableColor.iterative.hideInactiveLayers)
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(.circle)
                    case .failure:
                        Image(systemName: "exclamationmark.triangle.fill")
                    @unknown default:
                        Image(systemName: "questionmark.triangle.fill")
                    }
                }
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
