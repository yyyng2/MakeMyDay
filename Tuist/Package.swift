// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [
            "ComposableArchitecture": .framework,
            "GoogleMobileAds": .framework,
            "FirebaseAnalyticsWithoutAdId": .staticLibrary,
            "FirebaseCrashlytics": .staticLibrary,
        ]
    )
#endif

let package = Package(
    name: "MakeMyDay",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.23.0"),
        .package(url: "https://github.com/pointfreeco/swift-navigation", from: "2.6.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", from: "12.12.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "12.4.0"),
    ]
)
