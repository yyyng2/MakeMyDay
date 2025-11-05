import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project.makeModule(
    name: "UIComponents",
    product: .framework,
    sources: ["Sources/**"],
    dependencies: [],
    needTest: false
)
