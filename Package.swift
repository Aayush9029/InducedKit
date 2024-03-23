// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Induced",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "Induced",
            targets: ["Induced"]),
    ],
    targets: [
        .target(
            name: "Induced"),
        .testTarget(
            name: "InducedTests",
            dependencies: ["Induced"]),
    ])
