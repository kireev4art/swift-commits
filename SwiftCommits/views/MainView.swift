import SwiftUI


struct MainView: View {

    var body: some View {
        TabView {
            Tab("GitHub API", systemImage: "globe") {
                GithubCommitsView()
            }
            Tab("SwiftData", systemImage: "swiftdata") {
                SwiftDataCommitsView()
            }
        }
    }

}


#Preview {
    MainView()
        .modelContainer(SwiftDataStore.shared.previewContainer)
}
