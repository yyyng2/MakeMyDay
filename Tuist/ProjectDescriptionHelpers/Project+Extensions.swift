import ProjectDescription

extension Project {
    public static func makeModule(
        name: String,
        organizationName: String = "MakeMyDay",
        product: Product = .framework,
        deploymentTarget: DeploymentTargets? = .iOS("17.0"),
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        entitlements: ProjectDescription.Entitlements? = nil,
        scripts: [ProjectDescription.TargetScript] = [],
        dependencies: [TargetDependency] = [],
        settings: Settings? = .settings(
            base: [
                "SWIFT_EMIT_LOC_STRINGS": "YES"
            ],
            debug: [:],
            release: [:],
            defaultSettings: .recommended
        ),
        needTest: Bool = true,
    ) -> Project {
        let targets = Target.makeTargets(
            name: name,
            destinations: .iOS,
            product: product,
            baseBundleId: product == .app ? "io.github.yyyng2.MakeMyDay" : "io.github.yyyng2.MakeMyDay.\(name)",
            deploymentTargets: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings,
            needTest: needTest,
        )
        
        return Project(
            name: name,
            organizationName: organizationName,
            targets: targets
        )
    }
}
