import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "Utilities",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [],
    needTest: false
)
