// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "PersonalWebsite",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
		.package(url: "http://github.com/vapor/leaf.git", from: "3.0.0"),
		.package(url: "https://github.com/conaloneill/MailCore.git", .branch("master")),
		.package(url: "https://github.com/vapor-community/VaporMonitoring.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Leaf", "MailCore", "VaporMonitoring"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)

