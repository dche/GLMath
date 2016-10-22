//
// GLMath - ApproxEq.swift
//
// ApproxEquatable protocol.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

/// Approximate equatable.
public protocol ApproxEquatable {

    /// The underlying float point number type.
    associatedtype NumberType: BaseFloat

    /// Approximate comparison.
    ///
    /// - parameter to: Other number to be compared.
    /// - parameter tolerance: If `to` is zero, this is the maximal absolute
    ///   difference, other wise, it is the maximal relative error. On the
    ///   latter case, `1.ulp` or its small mutiple are appropriate values.
    /// - returns: `true` if `self` is close to `to`.
    func isClose(to: Self, tolerance: NumberType) -> Bool
}

/// Approximate equality operator.
///
/// The default implementation provided by `ApproxEquatable` just calls
/// `isClose(to:tolerance:)` with `tolerance` set to `.epsilon`.
infix operator ~== : ComparisonPrecedence

extension ApproxEquatable {

    public static func ~== (lhs: Self, rhs: Self) -> Bool {
        return lhs.isClose(to: rhs, tolerance: Self.NumberType.epsilon)
    }
}

extension Float: ApproxEquatable {

    public typealias NumberType = Float

    public func isClose(to other: Float, tolerance: Float = .epsilon) -> Bool {
        if other.isZero {
            return abs(self) <= tolerance
        }
        let diff = abs(self - other)
        let m = max(abs(self), abs(other))
        return diff <= m * tolerance
    }
}

extension Double: ApproxEquatable {

    public typealias NumberType = Double

    public func isClose(to other: Double, tolerance: Double = .epsilon) -> Bool {
        if other.isZero {
            return abs(self) <= tolerance
        }
        let diff = abs(self - other)
        let m = max(abs(self), abs(other))
        return diff <= m * tolerance
    }
}
