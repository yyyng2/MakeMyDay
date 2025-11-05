import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "SettingsFeature",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Core", path: .relativeToRoot("Core")),
        .project(target: "Domain", path: .relativeToRoot("Shared/Domain")),
        .project(target: "Resources", path: .relativeToRoot("Shared/Resources")),
        .project(target: "UIComponents", path: .relativeToRoot("Shared/UIComponents")),
        .project(target: "Utilities", path: .relativeToRoot("Shared/Utilities")),
        .external(name: "ComposableArchitecture")
    ],
    needTest: false
)
