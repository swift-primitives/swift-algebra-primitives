// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-algebra-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "Algebra Primitive",
            targets: ["Algebra Primitive"]
        ),

        .library(
            name: "Algebra Magma Primitives",
            targets: ["Algebra Magma Primitives"]
        ),
        .library(
            name: "Algebra Semigroup Primitives",
            targets: ["Algebra Semigroup Primitives"]
        ),
        .library(
            name: "Algebra Monoid Primitives",
            targets: ["Algebra Monoid Primitives"]
        ),
        .library(
            name: "Algebra Semiring Primitives",
            targets: ["Algebra Semiring Primitives"]
        ),
        .library(
            name: "Algebra Semilattice Primitives",
            targets: ["Algebra Semilattice Primitives"]
        ),
        .library(
            name: "Algebra Lattice Primitives",
            targets: ["Algebra Lattice Primitives"]
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
            name: "Algebra Module Primitives",
            targets: ["Algebra Module Primitives"]
        ),

        .library(
            name: "Algebra Law Primitives",
            targets: ["Algebra Law Primitives"]
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

        .target(
            name: "Algebra Primitive",
            dependencies: []
        ),

        .target(
            name: "Algebra Magma Primitives",
            dependencies: [
                "Algebra Primitive"
            ]
        ),
        .target(
            name: "Algebra Semigroup Primitives",
            dependencies: [
                "Algebra Magma Primitives"
            ]
        ),
        .target(
            name: "Algebra Monoid Primitives",
            dependencies: [
                "Algebra Semigroup Primitives"
            ]
        ),
        .target(
            name: "Algebra Semiring Primitives",
            dependencies: [
                "Algebra Monoid Primitives"
            ]
        ),
        .target(
            name: "Algebra Semilattice Primitives",
            dependencies: [
                "Algebra Monoid Primitives",
                "Algebra Semigroup Primitives",
            ]
        ),
        .target(
            name: "Algebra Lattice Primitives",
            dependencies: [
                "Algebra Semilattice Primitives"
            ]
        ),
        .target(
            name: "Algebra Group Primitives",
            dependencies: [
                "Algebra Monoid Primitives"
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
                "Algebra Ring Primitives"
            ]
        ),
        .target(
            name: "Algebra Module Primitives",
            dependencies: [
                "Algebra Field Primitives"
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
            name: "Algebra Primitives",
            dependencies: [
                "Algebra Primitive",
                "Algebra Magma Primitives",
                "Algebra Semigroup Primitives",
                "Algebra Monoid Primitives",
                "Algebra Semiring Primitives",
                "Algebra Semilattice Primitives",
                "Algebra Lattice Primitives",
                "Algebra Group Primitives",
                "Algebra Ring Primitives",
                "Algebra Field Primitives",
                "Algebra Module Primitives",
                "Algebra Law Primitives",
            ]
        ),

        .target(
            name: "Algebra Primitives Test Support",
            dependencies: [
                "Algebra Primitives"
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Algebra Primitives Tests",
            dependencies: [
                "Algebra Primitives",
                "Algebra Primitives Test Support",
                "Algebra Magma Primitives",
                "Algebra Semigroup Primitives",
                "Algebra Monoid Primitives",
                "Algebra Semiring Primitives",
                "Algebra Semilattice Primitives",
                "Algebra Lattice Primitives",
                "Algebra Group Primitives",
                "Algebra Ring Primitives",
                "Algebra Field Primitives",
                "Algebra Module Primitives",
                "Algebra Law Primitives",
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
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
