import SwiftUI


struct SwiftCommitsView: View {

    @State var source: Source = .github

    @State var isLoading: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Commits source", selection: $source) {
                    ForEach(Source.allCases) { source in
                        Text(String(String(describing: source)))
                    }
                }
                .pickerStyle(.segmented)
                List {
                    ForEach(0..<30, id: \.self) { element in
                        CommitView(commit: .init(sha: "SHA", message: "Message", author: "Author", avatar: nil))
                    }
                    HStack(alignment: .center) {
                        loading
                    }
                    .onScrollVisibilityChange { isVisible in
                        if isVisible {
                            isLoading = true
                        }
                    }
                }
                .listStyle(.inset)
            }
            .navigationTitle("Swift Commits")
        }
    }

    var loading: some View {
        let string = isLoading ? "loading..." : "the end"
        return Text(string)
    }

}


#Preview {
    SwiftCommitsView()
}
