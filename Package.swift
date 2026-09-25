// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "fmcode",
    platforms: [
        .macOS(.v26)
    ],
    targets: [
        .executableTarget(
            name: "fmcode",
            path: "Sources/fmcode",
            exclude: [
                "test.py"
            ]
        )
    ]
)
