import SwiftUI


struct SwiftCommitsView: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section {
                        ForEach(model.commits) { commit in
                            CommitView(commit: commit)
                        }
                    } header: {
                        Picker("Commits source", selection: $model.source) {
                            ForEach(Source.allCases) { source in    // TODO: replace with model.property
                                Text(String(describing: source))
                                    .textCase(nil)
                            }
                        }
                        .pickerStyle(.segmented)
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
            }
            .navigationTitle("Swift Commits")
        }
    }


    // MARK: - private

    @State
    private var model: SwiftCommitsModel = .init()

}


#Preview {
    SwiftCommitsView()
}
