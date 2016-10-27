//
// GLMath - Interpolatable.swift
//
// Interpolatable protocol.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

public protocol Interpolatable {

    associatedtype NumberType: FloatingPoint

    func interpolate(between y: Self, t: NumberType) -> Self
}
