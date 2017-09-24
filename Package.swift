// swift-tools-version:4.0
//
// GLMath - Package.swift
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import PackageDescription

let package = Package(
    name: "GLMath",
    products: [
        .library(
            name: "GLMath",
            targets: ["GLMath"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/dche/FlatUtil.git",
            .branch("master")
        )
    ],
    targets: [
        .target(
            name: "GLMath",
            dependencies: ["FlatUtil"],
            path: "Sources"
        ),
        .testTarget(
            name: "GLMathTests",
            dependencies: ["GLMath"],
            path: "Tests/GLMathTests"
        )
    ]
)
