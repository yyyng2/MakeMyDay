import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "Domain",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [],
    needTest: false
)
