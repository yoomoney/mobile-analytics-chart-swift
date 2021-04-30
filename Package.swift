// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MobileAnalyticsChartSwift",
  platforms: [
    .iOS(.v11),
  ],
  products: [
    .library(
      name: "MobileAnalyticsChartSwift",
      targets: ["MobileAnalyticsChartSwift"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "MobileAnalyticsChartSwift",
      dependencies: [],
      path: "MobileAnalyticsChartSwift"
    ),
  ]
)
