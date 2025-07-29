// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "TanoshiiRecipeKit",
  defaultLocalization: "en",
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
    .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.5.0"),
    .package(url: "https://github.com/zunda-pixel/LicenseProvider.git", from: "1.5.1"),
  ],
  targets: [
    .target(
      name: "TanoshiiRecipeUI",
      dependencies: [
        .target(name: "TanoshiiRecipeAPI"),
        .product(name: "Kingfisher", package: "Kingfisher"),
      ],
      plugins: [
        .plugin(name: "LicenseProviderPlugin", package: "LicenseProvider")
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
      dependencies: [
        .target(name: "TanoshiiRecipeAPI")
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .testTarget(
      name: "TanoshiiRecipeUILogicTests",
      dependencies: [
        .target(name: "TanoshiiRecipeUI")
      ]
    ),
  ]
)
