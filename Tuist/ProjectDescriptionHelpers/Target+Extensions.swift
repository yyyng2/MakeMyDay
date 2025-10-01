//
//  Target+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Y on 10/24/25.
//

import Foundation
import ProjectDescription

extension Target {
    public static func makeTargets(
        name: String,
        destinations: Destinations,
        product: Product,
        baseBundleId: String,
        deploymentTargets: DeploymentTargets?,
        infoPlist: InfoPlist,
        sources: SourceFilesList?,
        resources: ResourceFileElements?,
        entitlements: ProjectDescription.Entitlements? = nil,
        scripts: [ProjectDescription.TargetScript] = [],
        dependencies: [TargetDependency],
        settings: Settings?,
        needTest: Bool = true,
    ) -> [Target] {
        let mainTarget: Target = .target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: baseBundleId,
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings,
        )
        
        let testTarget: Target = .target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(baseBundleId)Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: name)
            ]
        )
        
        return needTest ? [mainTarget, testTarget] : [mainTarget]
    }
}
