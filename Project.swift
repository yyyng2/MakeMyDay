import ProjectDescription

let project = Project(
    name: "MakeMyDay",
    targets: [
        .target(
            name: "MakeMyDay",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.MakeMyDay",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "MakeMyDay/Sources",
                "MakeMyDay/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "MakeMyDayTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.MakeMyDayTests",
            infoPlist: .default,
            buildableFolders: [
                "MakeMyDay/Tests"
            ],
            dependencies: [.target(name: "MakeMyDay")]
        ),
    ]
)
