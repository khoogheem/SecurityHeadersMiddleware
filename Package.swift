// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SecurityHeadersMiddleware",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SecurityHeadersMiddleware",
            targets: ["SecurityHeadersMiddleware"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.3"),

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SecurityHeadersMiddleware",
            dependencies: ["Vapor"]),
        .testTarget(
            name: "SecurityHeadersMiddlewareTests",
            dependencies: ["SecurityHeadersMiddleware"]),
    ]
)
