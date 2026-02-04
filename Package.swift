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
            name: "Algebra Semiring Primitives",
            targets: ["Algebra Semiring Primitives"]
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
            name: "Algebra Law Primitives",
            targets: ["Algebra Law Primitives"]
        ),
        .library(
            name: "Algebra Module Primitives",
            targets: ["Algebra Module Primitives"]
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
            name: "Algebra Semiring Primitives",
            dependencies: [
                "Algebra Monoid Primitives",
            ]
        ),
        .target(
            name: "Algebra Ring Primitives",
            dependencies: [
                "Algebra Group Primitives",
                "Algebra Semiring Primitives",
            ]
        ),
        .target(
            name: "Algebra Field Primitives",
            dependencies: [
                "Algebra Ring Primitives",
            ]
        ),
        .target(
            name: "Algebra Law Primitives",
            dependencies: [
                "Algebra Field Primitives",
                "Algebra Module Primitives",
            ]
        ),
        .target(
            name: "Algebra Module Primitives",
            dependencies: [
                "Algebra Field Primitives",
            ]
        ),
        .target(
            name: "Algebra Primitives",
            dependencies: [
                "Algebra Field Primitives",
                "Algebra Law Primitives",
                "Algebra Module Primitives",
                .product(name: "Comparison Primitives", package: "swift-comparison-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Optic Primitives", package: "swift-optic-primitives"),
            ]
        ),
        .target(
            name: "Algebra Primitives Test Support",
            dependencies: [
                "Algebra Primitives",
                .product(name: "Finite Primitives Test Support", package: "swift-finite-primitives"),
            ],
            path: "Tests/Support"
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
            name: "Algebra Semiring Primitives Tests",
            dependencies: [
                "Algebra Semiring Primitives",
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
            name: "Algebra Law Primitives Tests",
            dependencies: [
                "Algebra Law Primitives",
            ]
        ),
        .testTarget(
            name: "Algebra Module Primitives Tests",
            dependencies: [
                "Algebra Primitives",
            ]
        ),
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
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableExperimentalFeature("Lifetimes"),
        .strictMemorySafety()
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
