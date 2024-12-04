import SwiftUI


struct AuthorLabel: View {

    var name: String

    var avatar: URL?

    var body: some View {
        Label {
            Text(name)
                .font(Self.nameFont)
        } icon: {
            AuthorAsyncImage(url: avatar)
                .frame(width: scaledImageSize, height: scaledImageSize)
        }
    }


    // MARK: - private

    // didn't find an elegant way to use a single contstant, so following lines should always be in sync.
    private static let nameFont: Font = .title2
    private static let nameTextStyle: Font.TextStyle = .title2

    private static let defaultImageSize: CGFloat = 30

    @ScaledMetric(relativeTo: nameTextStyle)
    private var scaledImageSize: CGFloat = defaultImageSize

}


#Preview {
    AuthorLabel(name: "John Doe", avatar: nil)
}
