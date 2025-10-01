import ProjectDescription

let project = Project(
    name: "MakeMyDay",
    targets: [
        .target(
            name: "MakeMyDay",
            destinations: .iOS,
            product: .app,
            bundleId: "io.github.yyyng2.MakeMyDay",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "Sources",
                "Resources",
            ],
            dependencies: []
        ),
    ]
)
