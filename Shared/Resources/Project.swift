import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "Resources",
    product: .framework,
    resources: ["Resources/**"],
    dependencies: [],
    needTest: false
)
