import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "Core",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Shared/Domain")),
        .project(target: "Data", path: .relativeToRoot("Shared/Data")),
        .project(target: "Services", path: .relativeToRoot("Services")),
        .external(name: "ComposableArchitecture")
    ],
    needTest: false
)
