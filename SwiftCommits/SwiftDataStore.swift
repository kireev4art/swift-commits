import SwiftData


@MainActor
final class SwiftDataStore {

    static let shared: SwiftDataStore = .init()
    private init() {
        mainContainer = Self.createContainer()
        #if DEBUG
        previewContainer = Self.createContainer(inMemory: true)
        #endif
    }

    let mainContainer: ModelContainer

    #if DEBUG
    let previewContainer: ModelContainer
    #endif


    // MARK: - private

    private static func createContainer(inMemory: Bool = false) -> ModelContainer {
        let schema = Schema([
            CommitModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

}
