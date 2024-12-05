import SwiftUI


@main
struct App: SwiftUI.App {

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(SwiftDataStore.shared.mainContainer)
    }

}
