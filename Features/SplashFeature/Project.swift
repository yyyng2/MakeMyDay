import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "SplashFeature",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Core", path: .relativeToRoot("Core")),
        .project(target: "Utilities", path: .relativeToRoot("Shared/Utilities")),
        .external(name: "ComposableArchitecture")
    ],
    needTest: false
)
