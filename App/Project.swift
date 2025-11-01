import ProjectDescription
import ProjectDescriptionHelpers

private let project = Project(
    name: "MakeMyDay",
    options: .options(
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "en"
    ),
    settings: .settings(
        base: [
            "SWIFT_EMIT_LOC_STRINGS": "YES",
            "OTHER_LDFLAGS": "$(inherited) -ObjC" 
        ],
        configurations: [
            .debug(name: "Debug", xcconfig: .relativeToRoot("XCConfig/Debug.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToRoot("XCConfig/Release.xcconfig"))
        ]
    ),
    targets: [
        .target(
            name: "MakeMyDay",
            destinations: .iOS,
            product: .app,
            bundleId: "io.github.yyyng2.MakeMyDay",
//            infoPlist: .file(path: "Resources/Info.plist"),
            infoPlist: .extendingDefault(with: [
                       "CFBundleShortVersionString": "1.4.2",
                       "CFBundleVersion": "1",
                       "CFBundleDevelopmentRegion": "en",
                       "CFBundleLocalizations": ["en", "ko"],
                       "ITSAppUsesNonExemptEncryption": "false",
                       "UILaunchScreen": [:],
                       "UISupportedInterfaceOrientations": [
                           "UIInterfaceOrientationPortrait",
                       ],
                       "UISupportedInterfaceOrientations~ipad": [
                           "UIInterfaceOrientationPortrait",
                       ],
//                       "NSUserTrackingUsageDescription": "This app requests permission to track your activity for better ad recommendations.",
                       "NSUserTrackingUsageDescription": "$(NSUserTrackingUsageDescription)",
//                       "NSUserTrackingUsageDescription": .dictionary([
//                             "en": "This app requests permission to track your activity for better ad recommendations.",
//                             "ko": "더 나은 광고 추천을 위해 활동 추적 권한을 요청합니다."
//                         ]),
                       "UIUserInterfaceStyle": "Light",
                       "UIRequiresFullScreen": "true",
                       "FirebaseCrashlyticsCollectionEnabled": "true",
                       "GADApplicationIdentifier": "$(GAD_APPLICATION_ID)",
                       "GADBannerUnitID": "$(GAD_BANNER_UNIT_ID)",
                       "SKAdNetworkItems": [
                           ["SKAdNetworkIdentifier": "cstr6suwn9.skadnetwork"],
                           ["SKAdNetworkIdentifier": "4fzdc2evr5.skadnetwork"],
                           ["SKAdNetworkIdentifier": "2fnua5tdw4.skadnetwork"],
                           ["SKAdNetworkIdentifier": "ydx93a7ass.skadnetwork"],
                           ["SKAdNetworkIdentifier": "p78axxw29g.skadnetwork"],
                           ["SKAdNetworkIdentifier": "v72qych5uu.skadnetwork"],
                           ["SKAdNetworkIdentifier": "ludvb6z3bs.skadnetwork"],
                           ["SKAdNetworkIdentifier": "cp8zw746q7.skadnetwork"],
                           ["SKAdNetworkIdentifier": "3sh42y64q3.skadnetwork"],
                           ["SKAdNetworkIdentifier": "c6k4g5qg8m.skadnetwork"],
                           ["SKAdNetworkIdentifier": "s39g8k73mm.skadnetwork"],
                           ["SKAdNetworkIdentifier": "3qy4746246.skadnetwork"],
                           ["SKAdNetworkIdentifier": "f38h382jlk.skadnetwork"],
                           ["SKAdNetworkIdentifier": "hs6bdukanm.skadnetwork"],
                           ["SKAdNetworkIdentifier": "mlmmfzh3r3.skadnetwork"],
                           ["SKAdNetworkIdentifier": "v4nxqhlyqp.skadnetwork"],
                           ["SKAdNetworkIdentifier": "wzmmz9fp6w.skadnetwork"],
                           ["SKAdNetworkIdentifier": "su67r6k2v3.skadnetwork"],
                           ["SKAdNetworkIdentifier": "yclnxrl5pm.skadnetwork"],
                           ["SKAdNetworkIdentifier": "t38b2kh725.skadnetwork"],
                           ["SKAdNetworkIdentifier": "7ug5zh24hu.skadnetwork"],
                           ["SKAdNetworkIdentifier": "gta9lk7p23.skadnetwork"],
                           ["SKAdNetworkIdentifier": "vutu7akeur.skadnetwork"],
                           ["SKAdNetworkIdentifier": "y5ghdn5j9k.skadnetwork"],
                           ["SKAdNetworkIdentifier": "v9wttpbfk9.skadnetwork"],
                           ["SKAdNetworkIdentifier": "n38lu8286q.skadnetwork"],
                           ["SKAdNetworkIdentifier": "47vhws6wlr.skadnetwork"],
                           ["SKAdNetworkIdentifier": "kbd757ywx3.skadnetwork"],
                           ["SKAdNetworkIdentifier": "9t245vhmpl.skadnetwork"],
                           ["SKAdNetworkIdentifier": "a2p9lx4jpn.skadnetwork"],
                           ["SKAdNetworkIdentifier": "22mmun2rn5.skadnetwork"],
                           ["SKAdNetworkIdentifier": "44jx6755aq.skadnetwork"],
                           ["SKAdNetworkIdentifier": "k674qkevps.skadnetwork"],
                           ["SKAdNetworkIdentifier": "4468km3ulz.skadnetwork"],
                           ["SKAdNetworkIdentifier": "2u9pt9hc89.skadnetwork"],
                           ["SKAdNetworkIdentifier": "8s468mfl3y.skadnetwork"],
                           ["SKAdNetworkIdentifier": "klf5c3l5u5.skadnetwork"],
                           ["SKAdNetworkIdentifier": "ppxm28t8ap.skadnetwork"],
                           ["SKAdNetworkIdentifier": "kbmxgpxpgc.skadnetwork"],
                           ["SKAdNetworkIdentifier": "uw77j35x4d.skadnetwork"],
                           ["SKAdNetworkIdentifier": "578prtvx9j.skadnetwork"],
                           ["SKAdNetworkIdentifier": "4dzt52r2t5.skadnetwork"],
                           ["SKAdNetworkIdentifier": "tl55sbb4fm.skadnetwork"],
                           ["SKAdNetworkIdentifier": "c3frkrj4fj.skadnetwork"],
                           ["SKAdNetworkIdentifier": "e5fvkxwrpn.skadnetwork"],
                           ["SKAdNetworkIdentifier": "8c4e2ghe7u.skadnetwork"],
                           ["SKAdNetworkIdentifier": "3rd42ekr43.skadnetwork"],
                           ["SKAdNetworkIdentifier": "97r2b46745.skadnetwork"],
                           ["SKAdNetworkIdentifier": "3qcr597p9d.skadnetwork"]
                       ],
                   ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: .file(path: "Signing/App.entitlements"),
            scripts: [
                .post(
                    script: """
                      #!/bin/sh

                      echo "[Script] CHECKING dSYM: ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
                      ls -l "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"

                      "${PROJECT_DIR}/../Tuist/.build/checkouts/firebase-ios-sdk/Crashlytics/run"
                      """,
                    name: "Firebase Crashlytics Upload dSYMs",
                    inputPaths: [
                        "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}",
                        "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}",
                        "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist",
                        "$(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist",
                        "$(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)"
                    ],
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .target(name: "WidgetFeature"),
                .project(target: "SplashFeature", path: .relativeToRoot("Features/SplashFeature")),
                .project(target: "MainTabBarFeature", path: .relativeToRoot("Features/MainTabBarFeature")),
                .project(target: "Core", path: .relativeToRoot("Core")),
                .project(target: "Domain", path: .relativeToRoot("Shared/Domain")),
                .external(name: "ComposableArchitecture"),
                .external(name: "GoogleMobileAds"),
                .external(name: "FirebaseCore"),
                .external(name: "FirebaseCrashlytics"),
            ],
            settings: .settings(
                base: [:],
                defaultSettings: .recommended
            ),
        ),
        .target(
            name: "WidgetFeature",
            destinations: .iOS,
            product: .appExtension,
            bundleId: "io.github.yyyng2.MakeMyDay.WidgetFeature",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "MakeMyDayWidget",
                "NSExtension": [
                    "NSExtensionPointIdentifier": "com.apple.widgetkit-extension"
                ],
            ]),
            sources: ["WidgetFeature/Sources/**"],
            resources: ["WidgetFeature/Resources/**"],
            entitlements: .file(path: "Signing/WidgetFeature.entitlements"),
            dependencies: [
                .project(target: "Domain", path: .relativeToRoot("Shared/Domain")),
                .project(target: "Data", path: .relativeToRoot("Shared/Data")),
                .project(target: "Utilities", path: .relativeToRoot("Shared/Utilities")),
                .project(target: "Resources", path: .relativeToRoot("Shared/Resources")),
            ],
            settings: .settings(
                base: [:],
                debug: [:],
                release: [:],
                defaultSettings: .recommended
            )
        )
    ]
)
