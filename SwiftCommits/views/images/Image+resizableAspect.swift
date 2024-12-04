import SwiftUI


extension Image {

    func resizableAspect(ratio: CGFloat? = nil, to contentMode: ContentMode) -> some View {
        self
            .resizable()
            .aspectRatio(ratio, contentMode: contentMode)
    }

}
