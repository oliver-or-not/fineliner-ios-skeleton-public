// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Universe",
    platforms: [
        .iOS(.v18),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Universe",
            targets: [
                "Universe",
            ]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Unit",
            path: "Sources/Unit"
        ),
        .target(
            name: "Operator",
            path: "Sources/Operator"
        ),
        .target(
            name: "DataStructure",
            path: "Sources/DataStructure"
        ),
        .target(
            name: "Universe",
            dependencies: [
                "Unit",
                "Operator",
                "DataStructure",
            ],
            path: "Sources/Universe"
        ),
    ]
)
