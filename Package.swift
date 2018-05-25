// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "PersonalWebsite",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
		.package(url: "http://github.com/vapor/leaf.git", from: "3.0.0-rc"),
		.package(url: "https://github.com/vapor-community/sendgrid-provider.git", from: "3.0.0"),
		.package(url: "https://github.com/LiveUI/MailCore.git", .branch("master"))
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Leaf", "SendGrid", "MailCore"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)

