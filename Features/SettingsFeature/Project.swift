import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "SettingsFeature",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Core", path: .relativeToRoot("Core")),
        .project(target: "UIComponents", path: .relativeToRoot("Shared/UIComponents")),
        .project(target: "Utilities", path: .relativeToRoot("Shared/Utilities")),
        .external(name: "ComposableArchitecture")
    ],
    needTest: false
)
