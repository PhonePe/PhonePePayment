// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PhonePePayment",
    
    platforms: [
            .iOS(.v11)
        ],
    products: [
        .library(
            name: "PhonePePayment",
            targets: ["PhonePePayment"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
                    name: "PhonePePayment",
                    path: "PhonePePayment.xcframework"
                    
        ),
        .testTarget(
            name: "PhonePePaymentTests",
            dependencies: ["PhonePePayment"]),
    ]
)
