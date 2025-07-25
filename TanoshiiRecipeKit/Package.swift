// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "TanoshiiRecipeKit",
  platforms: [
    .iOS(.v18),
    .macOS(.v15),
  ],
  products: [
    .library(
      name: "TanoshiiRecipeUI",
      targets: ["TanoshiiRecipeUI"]
    ),
    .library(
      name: "TanoshiiRecipeAPI",
      targets: ["TanoshiiRecipeAPI"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-http-types.git", from: "1.4.0"),
    .package(url: "https://github.com/gohanlon/swift-memberwise-init-macro.git", from: "0.5.2"),
  ],
  targets: [
    .target(
      name: "TanoshiiRecipeUI",
      dependencies: [
        .target(name: "TanoshiiRecipeAPI")
      ]
    ),
    .target(
      name: "TanoshiiRecipeAPI",
      dependencies: [
        .product(name: "HTTPTypes", package: "swift-http-types"),
        .product(name: "HTTPTypesFoundation", package: "swift-http-types"),
        .product(name: "MemberwiseInit", package: "swift-memberwise-init-macro"),
      ]
    ),
    .testTarget(
      name: "TanoshiiRecipeAPITests",
      dependencies: ["TanoshiiRecipeAPI"],
      resources: [
        .process("Resources")
      ]
    ),
  ]
)
