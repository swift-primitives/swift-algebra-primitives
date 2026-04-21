// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-algebra-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        // MARK: - Namespace
        .library(
            name: "Algebra Namespace",
            targets: ["Algebra Namespace"]
        ),
        .library(
            name: "Algebra Primitives Core",
            targets: ["Algebra Primitives Core"]
        ),
        .library(
            name: "Algebra Primitives",
            targets: ["Algebra Primitives"]
        ),
        .library(
            name: "Algebra Primitives Test Support",
            targets: ["Algebra Primitives Test Support"]
        ),
    ],
    dependencies: [],
    targets: [
        // MARK: - Namespace
        .target(
            name: "Algebra Namespace",
            dependencies: []
        ),

        .target(
            name: "Algebra Primitives Core",
            dependencies: [
                "Algebra Namespace",
            ]
        ),
        .target(
            name: "Algebra Primitives",
            dependencies: [
                "Algebra Namespace",
                "Algebra Primitives Core",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Algebra Primitives Test Support",
            dependencies: [
                "Algebra Primitives",
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Algebra Primitives Tests",
            dependencies: [
                "Algebra Primitives",
                "Algebra Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
