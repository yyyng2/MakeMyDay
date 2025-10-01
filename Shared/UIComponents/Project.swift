import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "UIComponents",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Shared/Domain")),
        .project(target: "Resources", path: .relativeToRoot("Shared/Resources")),
        .project(target: "Utilities", path: .relativeToRoot("Shared/Utilities")),
    ],
    needTest: false
)
