// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BGGKit",
    platforms: [.macOS(.v10_12),
                .iOS(.v10),
                .tvOS(.v10),
                .watchOS(.v3)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "StackParsing",
            targets: ["StackParsing"]
        ),
        .library(
            name: "BGGXMLApi2",
            targets: ["BGGXMLApi2"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "StackParsing"
        ),
        .testTarget(
            name: "StackParsingTests",
            dependencies: [
                "StackParsing"
            ]
        ),
        .target(
            name: "BGGXMLApi2",
            dependencies: [
                "StackParsing"
            ]
        ),
        .testTarget(
            name: "BGGXMLApi2Tests",
            dependencies: [
                "BGGXMLApi2"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
