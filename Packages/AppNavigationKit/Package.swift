// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppNavigationKit",
    platforms: [ .iOS(.v16) ],
    products: [
        .library(
            name: "AppNavigationKit",
            targets: ["AppNavigationKit"]),
    ],
    dependencies: [
        .package(path: "../UtilKit"),
    ],
    targets: [
        .target(
            name: "AppNavigationKit",
            dependencies: [
                "UtilKit"
            ]),
        .testTarget(
            name: "AppNavigationKitTests",
            dependencies: ["AppNavigationKit"]),
    ]
)
