// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "PersonalWebsite",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor-community/sendgrid.git", from: "4.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Leaf", package: "leaf"),
            .product(name: "SendGrid", package: "sendgrid"),
        ]),
        .target(name: "Run", dependencies: [
            .target(name: "App")
        ]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
        ])
    ]
)

