import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "Data",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Shared/Domain")),
    ],
    needTest: false
)
