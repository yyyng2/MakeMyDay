import Foundation
import SwiftData
import Domain

public struct ModelContainerClient {
    public static func create(schemas: [any PersistentModel.Type]) -> ModelContainer {
        let schema = Schema(schemas)
        
        do {
            let appGroupIdentifier = "group.io.github.yyyng2.MakeMyDay"
            guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier) else {
                throw NSError(domain: "AppGroupError", code: 1, userInfo: [NSLocalizedDescriptionKey: "App Group container not found"])
            }
            let url = containerURL.appendingPathComponent("database.sqlite")
            
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                url: url,
                allowsSave: true,
            )
            
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
