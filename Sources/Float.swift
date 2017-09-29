//
// GLMath - Float.swift
//
// Float scalar and vector types.
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

/// Approximate equatable.
public protocol ApproxEquatable {

    /// The underlying float pointing number type for comparison.
    associatedtype InexactNumber: FloatingPoint

    /// Approximate comparison.
    ///
    /// - parameter to: Other number to be compared.
    /// - parameter tolerance: If `to` is zero, this is the maximal absolute
    ///   difference, other wise, it is the maximal relative error. On the
    ///   latter case, `1.ulp` or its small mutiple are appropriate values.
    /// - returns: `true` if `self` is close to `to`.
    func isClose(to: Self, tolerance: InexactNumber) -> Bool
}

/// Approximate equality operator.
///
/// The default implementation provided by `ApproxEquatable` just calls
/// `isClose(to:tolerance:)` with `tolerance` set to `.epsilon`.
infix operator ~== : ComparisonPrecedence

extension ApproxEquatable {

    public static func ~== (lhs: Self, rhs: Self) -> Bool {
        return lhs.isClose(to: rhs, tolerance: Self.InexactNumber.ulpOfOne)
    }
}

/// Generic floating point number type that applies to both scalar and
/// vector numbers.
public protocol GenericFloat: GenericSignedNumber, ApproxEquatable, Interpolatable {

    var fract: Self { get }
    var recip: Self { get }
    var rsqrt: Self { get }

    func step(_ edge: Self) -> Self
}

/// Type for primitive floating point types. Adopted by `Float` and `Double`.
public protocol BaseFloat: BaseNumber, GenericFloat
    where
    InexactNumber == Self,
    InterpolatableNumber == Self
{
    var sin: Self { get }
    var cos: Self { get }
    var acos: Self { get }
    var sqrt: Self { get }

    var frexp: (Self, Int) { get }
    func ldexp(_ exp: Int) -> Self
}

extension BaseFloat {

    public var signum: Self {
        guard self != 0 else { return Self.zero }
        switch self.sign {
        case .minus:
            return -Self.one
        case .plus:
            return Self.one
        }
    }

    public func isClose(to other: Self, tolerance: Self = Self.epsilon) -> Bool {
        if other.isZero {
            return abs(self) <= tolerance
        }
        let diff = abs(self - other)
        let m = max(abs(self), abs(other))
        return diff <= m * tolerance
    }

    public func interpolate(_ y: Self, t: Self) -> Self {
        return self * (Self.one - t) + y * t
    }
}

extension Float: BaseFloat {

    public typealias InexactNumber = Float
    public typealias InterpolatableNumber = Float

    public static let zero: Float = 0
    public static let one: Float = 1
}

extension Double: BaseFloat {

    public typealias InexactNumber = Double
    public typealias InterpolatableNumber = Double

    public static let zero: Double = 0
    public static let one: Double = 1
}

/// Float number vector.
public protocol FloatVector: NumericVector, GenericFloat
    where
    Component: BaseFloat,
    Component == InexactNumber
{
    var length: Component { get }
    var normalize: Self { get }

    func distance(to other: Self) -> Component
    func dot(_ other: Self) -> Component
    func mix(_ other: Self, t: Self) -> Self
    func smoothstep(_ edge0: Self, _ edge1: Self) -> Self
}

extension FloatVector {

    public func isClose(
        to other: Self,
        tolerance: Component = .epsilon
    ) -> Bool {
        for i in 0 ..< Self.dimension {
            guard self[i].isClose(to: other[i], tolerance: tolerance) else {
                return false
            }
        }
        return true
    }
}

extension FloatVector where Component == InterpolatableNumber {

    public func interpolate(_ y: Self, t: Component) -> Self {
        return self.mix(y, t: Self(t))
    }

    /// Geometric Slerp.
    public func slerp(_ y: Self, t: Component) -> Self {
        let theta = self.angle(between: y)
        if theta ~== 0 || theta ~== .pi {
            return self.interpolate(y, t: t)
        }
        let a = (theta - t * theta).sin
        let b = (t * theta).sin
        let c = (theta).sin.recip
        let d = self * a
        let e = y * b
        return (d + e) * c
    }
}

public protocol FloatVector2: FloatVector, Vector2 {}

extension FloatVector2 {

    public static var x: Self { return self.init(1, 0) }
    public static var y: Self { return self.init(0, 1) }
}

public protocol FloatVector3: FloatVector, Vector3
    where
    AssociatedVector2: FloatVector2
{

    // Generic `cross` method declaration.
    func cross(_ y: Self) -> Self
}

extension FloatVector3 {

    public static var x: Self { return self.init(1, 0, 0) }
    public static var y: Self { return self.init(0, 1, 0) }
    public static var z: Self { return self.init(0, 0, 1) }
}

public protocol FloatVector4: FloatVector, Vector4
    where
    AssociatedVector2: FloatVector2,
    AssociatedVector3: FloatVector3
{}

extension FloatVector4 {

    public static var x: Self { return self.init(1, 0, 0, 0) }
    public static var y: Self { return self.init(0, 1, 0, 0) }
    public static var z: Self { return self.init(0, 0, 1, 0) }
    public static var w: Self { return self.init(0, 0, 0, 1) }
}
