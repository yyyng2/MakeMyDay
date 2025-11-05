import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "SplashFeature",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Core", path: .relativeToRoot("Core")),
        .project(target: "Resources", path: .relativeToRoot("Shared/Resources")),
        .project(target: "UIComponents", path: .relativeToRoot("Shared/UIComponents")),
        .external(name: "ComposableArchitecture")
    ],
    needTest: false
)
