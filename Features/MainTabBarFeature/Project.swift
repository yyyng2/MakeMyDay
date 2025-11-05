import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "MainTabBarFeature",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Core", path: .relativeToRoot("Core")),
        .project(target: "Domain", path: .relativeToRoot("Shared/Domain")),
        .project(target: "HomeFeature", path: .relativeToRoot("Features/HomeFeature")),
        .project(target: "ScheduleFeature", path: .relativeToRoot("Features/ScheduleFeature")),
        .project(target: "DDayFeature", path: .relativeToRoot("Features/DDayFeature")),
        .project(target: "SettingsFeature", path: .relativeToRoot("Features/SettingsFeature")),
        .project(target: "Resources", path: .relativeToRoot("Shared/Resources")),
        .external(name: "ComposableArchitecture"),
    ],
    needTest: false
)
