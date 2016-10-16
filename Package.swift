//
// GLMath - Package.swift
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import PackageDescription

let package = Package(
    name: "GLMath",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/dche/FlatUtil.git",
                 majorVersion: 0),
    ]
)
