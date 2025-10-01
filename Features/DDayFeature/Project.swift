import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "DDayFeature",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Core", path: .relativeToRoot("Core")),
        .project(target: "Domain", path: .relativeToRoot("Shared/Domain")),
        .project(target: "Data", path: .relativeToRoot("Shared/Data")),
        .project(target: "UIComponents", path: .relativeToRoot("Shared/UIComponents")),
        .project(target: "Utilities", path: .relativeToRoot("Shared/Utilities")),
        .project(target: "Resources", path: .relativeToRoot("Shared/Resources")),
        .external(name: "ComposableArchitecture")
    ],
    needTest: false
)
