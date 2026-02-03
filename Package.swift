// swift-tools-version: 6.2

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
        .library(
            name: "Algebra Primitives Core",
            targets: ["Algebra Primitives Core"]
        ),
        .library(
            name: "Algebra Magma Primitives",
            targets: ["Algebra Magma Primitives"]
        ),
        .library(
            name: "Algebra Monoid Primitives",
            targets: ["Algebra Monoid Primitives"]
        ),
        .library(
            name: "Algebra Group Primitives",
            targets: ["Algebra Group Primitives"]
        ),
        .library(
            name: "Algebra Ring Primitives",
            targets: ["Algebra Ring Primitives"]
        ),
        .library(
            name: "Algebra Field Primitives",
            targets: ["Algebra Field Primitives"]
        ),
        .library(
            name: "Algebra Primitives",
            targets: ["Algebra Primitives"]
        )
    ],
    dependencies: [
        .package(path: "../swift-comparison-primitives"),
        .package(path: "../swift-finite-primitives"),
        .package(path: "../swift-optic-primitives"),
        .package(path: "../swift-witness-primitives"),
    ],
    targets: [
        .target(
            name: "Algebra Primitives Core",
            dependencies: []
        ),
        .target(
            name: "Algebra Magma Primitives",
            dependencies: [
                "Algebra Primitives Core",
                .product(name: "Witness Primitives", package: "swift-witness-primitives"),
            ]
        ),
        .target(
            name: "Algebra Monoid Primitives",
            dependencies: [
                "Algebra Magma Primitives",
            ]
        ),
        .target(
            name: "Algebra Group Primitives",
            dependencies: [
                "Algebra Monoid Primitives",
            ]
        ),
        .target(
            name: "Algebra Ring Primitives",
            dependencies: [
                "Algebra Group Primitives",
            ]
        ),
        .target(
            name: "Algebra Field Primitives",
            dependencies: [
                "Algebra Ring Primitives",
            ]
        ),
        .target(
            name: "Algebra Primitives",
            dependencies: [
                "Algebra Field Primitives",
                .product(name: "Comparison Primitives", package: "swift-comparison-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Optic Primitives", package: "swift-optic-primitives"),
            ]
        ),
        .testTarget(
            name: "Algebra Magma Primitives Tests",
            dependencies: [
                "Algebra Magma Primitives",
            ]
        ),
        .testTarget(
            name: "Algebra Monoid Primitives Tests",
            dependencies: [
                "Algebra Monoid Primitives",
            ]
        ),
        .testTarget(
            name: "Algebra Group Primitives Tests",
            dependencies: [
                "Algebra Group Primitives",
            ]
        ),
        .testTarget(
            name: "Algebra Ring Primitives Tests",
            dependencies: [
                "Algebra Ring Primitives",
            ]
        ),
        .testTarget(
            name: "Algebra Field Primitives Tests",
            dependencies: [
                "Algebra Field Primitives",
            ]
        ),
        .testTarget(
            name: "Algebra Primitives Tests",
            dependencies: [
                "Algebra Primitives",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableExperimentalFeature("Lifetimes"),
        .strictMemorySafety()
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
