// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InducedKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "InducedKit",
            targets: ["InducedKit"]),
    ],
    targets: [
        .target(
            name: "InducedKit"),
        .testTarget(
            name: "InducedTests",
            dependencies: ["InducedKit"]),
    ])
