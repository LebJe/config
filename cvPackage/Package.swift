// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cv",
	platforms: [.macOS(.v10_15)],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
		.package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
		.package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.3.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "cv",
            dependencies: [
				"ShellOut",
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			],
			swiftSettings: [
				.unsafeFlags(["-Xfrontend", "-parse-as-library"]),
			]
		),
        .testTarget(
            name: "cvTeststes",
            dependencies: ["cv"]
		),
		
    ]
)
