// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Default",
    products: [
        .library(
            name: "Default",
            targets: ["Default"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Default",
            dependencies: [],
            path: "Sources"
        ),
    ]
)
