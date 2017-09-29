//
// GLMath - Interpolation.swift
//
// Interpolatable protocol.
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

public protocol Interpolatable {

    associatedtype InterpolatableNumber: BinaryFloatingPoint

    /// Linear interplation between the receiver and `y` with parameter `t`.
    ///
    /// - note: `t` is not guaranteed to be wihtin range [0, 1].
    func interpolate(_ y: Self, t: InterpolatableNumber) -> Self
}
