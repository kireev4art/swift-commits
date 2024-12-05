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
                        Text(model.footer)
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
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save all", action: saveAll)
                }
            }
        }
    }


    // MARK: - private

    @State
    private var model: GithubCommitsModel = .init()

    @Environment(\.modelContext)
    private var modelContext

    private func saveAll() {
        for i in model.commits {
            let model = CommitModel(sha: i.sha, message: i.message, author: i.author, avatar: i.avatar)
            modelContext.insert(model)
        }
    }

}


#Preview {
    GithubCommitsView()
        .modelContainer(SwiftDataStore.shared.previewContainer)
}
