import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "Services",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Shared/Domain")),
        .project(target: "Data", path: .relativeToRoot("Shared/Data")),
    ],
    needTest: false
)
