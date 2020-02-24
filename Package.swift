// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "PersonalWebsite",
    platforms: [
       .macOS(.v10_14)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-beta"),
		.package(url: "http://github.com/vapor/leaf.git", from: "4.0.0-beta"),
		.package(url: "https://github.com/conaloneill/MailCore.git", .branch("master")),
        
    ],
    targets: [
        .target(name: "App", dependencies: [
            "Vapor",
            "Leaf",
            "MailCore"
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App", "XCTVapor"]),
    ]
)

