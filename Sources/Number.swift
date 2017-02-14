//
// GLMath - Number.swift
//
// Generic number protocols.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import FlatUtil

/// Additive group.
public protocol Zero: Equatable {

    /// The additive identity.
    static var zero: Self { get }

    /// Returns `true` if `self` equals to `zero`.
    var isZero: Bool { get }

    static func + (lhs: Self, rhs: Self) -> Self
}

public extension Zero {

    var isZero: Bool {
        return self == Self.zero
    }
}

/// Multiplicative group.
public protocol One: Equatable {

    /// The multiplicative identity.
    static var one: Self { get }

    /// Returns `true` if the `self` equals to `one`.
    var isOne: Bool { get }

    static func * (lhs: Self, rhs: Self) -> Self
}

public extension One {

    var isOne: Bool {
        return self == Self.one
    }
}

/// Generic number type. Instances includes both scalars and vectors.
public protocol GenericNumber: Zero, One, Random {

    static func / (lhs: Self, rhs: Self) -> Self
}

/// Marker type of primitive number types.
public typealias BaseNumber = GenericNumber & Comparable

/// Number types that have sign.
///
/// Much like the standard `SignedNumber` type, but with fewer constraints.
public protocol GenericSignedNumber: GenericNumber {

    static prefix func - (op: Self) -> Self

    static func - (lhs: Self, rhs: Self) -> Self
}
