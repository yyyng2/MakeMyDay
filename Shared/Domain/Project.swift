import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "Domain",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Resources", path: .relativeToRoot("Shared/Resources")),
    ],
    needTest: false
)
