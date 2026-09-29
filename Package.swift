// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "fmcode",
    platforms: [
        .macOS(.v26)
    ],
    targets: [
        .target(name: "core", path: "Sources/core"),
        .executableTarget(
            name: "fmcode",
            dependencies: ["core"],
            path: "Sources/fmcode",
        )
    ]
)
