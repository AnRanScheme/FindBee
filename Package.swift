// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FindBee",
    products: [
        .executable(name: "FindBee", targets: ["FindBee"]),
        ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Rainbow.git", from: "3.1.1"),
        .package(url: "https://github.com/jatoben/CommandLine.git", from: "3.0.0-pre1"),
        .package(url: "https://github.com/kylef/Spectre.git", from: "0.8.0"),
        .package(url: "https://github.com/kylef/PathKit.git", from: "0.9.0")
    ],
    targets: [
        .target(name: "FindBeeKit", dependencies: ["Rainbow", "PathKit"]),
        .target(name: "FindBee", dependencies: ["FindBeeKit", "CommandLine"]),
        .testTarget(name: "FindBeeKitTests", dependencies: ["FindBeeKit", "Spectre"], exclude: ["Tests/Fixtures"]),    
        ]
)
