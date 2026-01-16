// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-algebra-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Algebra Primitives",
            targets: ["Algebra Primitives"]
        ),
    ],
    dependencies: [
        .package(path: "../swift-test-primitives"),
    ],
    targets: [
        .target(
            name: "Algebra Primitives",
            dependencies: []
        ),
        .testTarget(
            name: "Algebra Primitives Tests",
            dependencies: [
                "Algebra Primitives",
                .product(name: "Test Primitives", package: "swift-test-primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .strictMemorySafety(),
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
