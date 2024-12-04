import SwiftUI


struct AuthorAsyncImage: View {

    var url: URL?

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                if url == nil {
                    Image(systemName: "person.crop.circle.fill")
                        .resizableAspect(to: .fit)
                        .foregroundStyle(.blue)
                } else {
                    Image(systemName: "progress.indicator")
                        .resizableAspect(to: .fit)
                        .symbolEffect(.variableColor.iterative.hideInactiveLayers)
                }
            case .success(let image):
                image
                    .resizableAspect(to: .fill)     // `.fill` is not a typo
                    .clipShape(.circle)
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizableAspect(to: .fit)
                    .foregroundStyle(.yellow)
            @unknown default:
                Image(systemName: "questionmark.triangle.fill")
                    .resizableAspect(to: .fit)
                    .foregroundStyle(.purple)
            }
        }
    }

}


#Preview("nil") {
    AuthorAsyncImage()
}


#Preview("google.com") {
    AuthorAsyncImage(url: URL(string: "https://google.com"))
}


#Preview("thispersondoesnotexist.com") {
    AuthorAsyncImage(url: URL(string: "https://thispersondoesnotexist.com"))
}
