import Foundation
import SwiftData
import Domain

public struct ModelContainerClientImpl: ModelContainerClient {
    public static func create(schemas: [any PersistentModel.Type]) -> ModelContainer {
        let schema = Schema(schemas)
        
        guard let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.io.github.yyyng2.MakeMyDay"
        ) else {
            fatalError("RepositoryError.containerNotFound")
        }
        
        let url = containerURL.appendingPathComponent("database.sqlite")
        let modelConfiguration = ModelConfiguration(schema: schema, url: url, allowsSave: true)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
