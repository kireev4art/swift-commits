import SwiftUI
import SwiftData


struct SwiftDataCommitsView: View {

    var body: some View {
        NavigationStack {
            List(commits) { model in
                CommitView(commit: .init(from: model))
            }
            .navigationTitle("SwiftData")
        }
    }


    // MARK: - private

    @Environment(\.modelContext)
    private var modelContext

    @Query var commits: [CommitModel]

}


internal extension Commit {

    init(from model: CommitModel) {
        self.avatar = model.avatar
        self.author = model.author
        self.message = model.message
        self.sha = model.sha
    }

}


#Preview {
    SwiftDataCommitsView()
        .modelContainer(for: CommitModel.self, inMemory: true)
}