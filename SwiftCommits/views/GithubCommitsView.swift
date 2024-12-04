import SwiftUI


struct GithubCommitsView: View {

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(model.commits) { commit in
                        CommitView(commit: commit)
                    }
                } footer: {
                    HStack(alignment: .center) {
                        Text(model.bottomText)
                            .opacity(model.commits.isEmpty ? 0 : 1)
                    }
                    .onScrollVisibilityChange { isVisible in
                        model.footer(isVisible: isVisible)
                    }
                }
            }
            .overlay {
                if model.isLoading && model.commits.isEmpty {
                    ContentUnavailableView {
                        Label("Loading...", systemImage: "progress.indicator")
                            .symbolEffect(.variableColor.hideInactiveLayers.iterative)
                    }
                }
            }
            .navigationTitle("Github API")
        }
    }


    // MARK: - private

    @State
    private var model: GithubCommitsModel = .init()

}


#Preview {
    GithubCommitsView()
}
