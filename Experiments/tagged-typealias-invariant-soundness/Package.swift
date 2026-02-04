// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "tagged-typealias-invariant-soundness",
    platforms: [.macOS(.v26)],
    dependencies: [
        .package(path: "../../../swift-identity-primitives"),
        .package(path: "../../../swift-ordinal-primitives"),
        .package(path: "../../../swift-finite-primitives"),
    ],
    targets: [
        .executableTarget(
            name: "tagged-typealias-invariant-soundness",
            dependencies: [
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
                .product(name: "Ordinal Primitives", package: "swift-ordinal-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("InternalImportsByDefault"),
                .enableUpcomingFeature("MemberImportVisibility"),
            ]
        )
    ]
)
