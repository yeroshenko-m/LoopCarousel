// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoopCarousel",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "LoopCarousel",
            targets: ["LoopCarousel"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LoopCarousel",
            dependencies: []),
        .testTarget(
            name: "LoopCarouselTests",
            dependencies: ["LoopCarousel"]),
    ]
)
