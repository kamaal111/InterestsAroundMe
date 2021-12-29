// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IAMNetworker",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "IAMNetworker",
            targets: ["IAMNetworker"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kamaal111/ShrimpExtensions.git", "2.3.0"..<"3.0.0"),
        .package(url: "https://github.com/kamaal111/XiphiasNet.git", "6.1.1"..<"6.2.0"),
    ],
    targets: [
        .target(
            name: "IAMNetworker",
            dependencies: [
                "ShrimpExtensions",
                "XiphiasNet",
            ]),
        .testTarget(
            name: "IAMNetworkerTests",
            dependencies: ["IAMNetworker"]),
    ]
)
