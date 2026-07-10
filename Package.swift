// swift-tools-version: 6.3.3

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
            name: "Algebra Primitive",
            targets: ["Algebra Primitive"]
        ),

        // MARK: - Sub-namespace targets (algebraic tower)
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

        // MARK: - Laws (atop the tower)
        .library(
            name: "Algebra Law Primitives",
            targets: ["Algebra Law Primitives"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Algebra Primitives",
            targets: ["Algebra Primitives"]
        ),

        // MARK: - Test Support
        .library(
            name: "Algebra Primitives Test Support",
            targets: ["Algebra Primitives Test Support"]
        ),
    ],
    dependencies: [],
    targets: [
        // MARK: - Namespace
        .target(
            name: "Algebra Primitive",
            dependencies: []
        ),

        // MARK: - Sub-namespace targets (algebraic tower, per [MOD-031])
        .target(
            name: "Algebra Magma Primitives",
            dependencies: [
                "Algebra Primitive",
            ]
        ),
        .target(
            name: "Algebra Semigroup Primitives",
            dependencies: [
                "Algebra Magma Primitives",
            ]
        ),
        .target(
            name: "Algebra Monoid Primitives",
            dependencies: [
                "Algebra Semigroup Primitives",
            ]
        ),
        .target(
            name: "Algebra Semiring Primitives",
            dependencies: [
                "Algebra Monoid Primitives",
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
                "Algebra Semilattice Primitives",
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
            name: "Algebra Module Primitives",
            dependencies: [
                "Algebra Field Primitives",
            ]
        ),

        // MARK: - Laws (atop the tower; intra-package deps keep core zero-external-dep)
        .target(
            name: "Algebra Law Primitives",
            dependencies: [
                "Algebra Field Primitives",
                "Algebra Module Primitives",
            ]
        ),

        // MARK: - Umbrella
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
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
