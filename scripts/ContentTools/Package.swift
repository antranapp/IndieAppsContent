// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ContentTools",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams", from: "3.0.1"),
        .package(url: "https://github.com/JohnSundell/Files", from: "3.1.0"),
        .package(url: "https://github.com/mtynior/ColorizeSwift", .branch("master")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "ContentTools",
            dependencies: [
                "Yams",
                "Files",
                "ColorizeSwift",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "."),
    ]
)
