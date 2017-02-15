//
// GLMath - Float.swift
//
// Float scalar and vector types.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

/// Generic float number type.
public protocol GenericFloat: GenericSignedNumber, ApproxEquatable, Interpolatable {

    var fract: Self { get }
    var recip: Self { get }
    var rsqrt: Self { get }

    func step(_ edge: Self) -> Self
}

/// Primitive float number type.
public protocol BaseFloat: BaseNumber, GenericFloat, FloatingPoint, ExpressibleByFloatLiteral {

    associatedtype NumberType = Self

    var sin: Self { get }
    var cos: Self { get }
    var acos: Self { get }
    var sqrt: Self { get }
    var frexp: (Self, Int) { get }
    func ldexp(_ exp: Int) -> Self
    func pow(_ exp: Self) -> Self

    init (_ other: Double)
}

extension BaseFloat {

    public func isClose(to other: Self, tolerance: Self = Self.epsilon) -> Bool {
        if other.isZero {
            return abs(self) <= tolerance
        }
        let diff = abs(self - other)
        let m = max(abs(self), abs(other))
        return diff <= m * tolerance
    }

    public func interpolate(between y: Self, t: Self) -> Self {
        return mix(self, y, t)
    }
}

extension Float: BaseFloat {

    public typealias NumberType = Float

    public static let zero: Float = 0
    public static let one: Float = 1
}

extension Double: BaseFloat {

    public typealias NumberType = Double

    public static let zero: Double = 0
    public static let one: Double = 1
}

/// Float number vector.
public protocol FloatVector: NumberVector, GenericFloat {

    associatedtype Component: BaseFloat

    associatedtype NumberType = Component

    var length: Component { get }
    var normalize: Self { get }

    func distance(to other: Self) -> Component
    func dot(_ other: Self) -> Component
    func mix(_ other: Self, t: Self) -> Self
    func smoothstep(_ edge0: Self, _ edge1: Self) -> Self
}

extension FloatVector {

    public static func / (lhs: Self, rhs: Component) -> Self {
        return lhs * rhs.recip
    }
}

extension FloatVector {

    public func isClose(to other: Self, tolerance: Component = .epsilon) -> Bool {
        for i in 0 ..< Self.dimension {
            guard self[i].isClose(to: other[i], tolerance: tolerance) else {
                return false
            }
        }
        return true
    }

    public func interpolate(between y: Self, t: Component) -> Self {
        return self.mix(y, t: Self(t))
    }

    /// Geometric Slerp.
    public func slerp(_ y: Self, t: Component) -> Self {
        let theta = self.angle(between: y)
        if theta ~== 0 || theta ~== .pi {
            return self.interpolate(between: y, t: t)
        }
        let a = (theta - t * theta).sin
        let b = (t * theta).sin
        let c = (theta).sin.recip
        return self * a * c + y * b * c
    }
}

public typealias FloatVector2 = FloatVector & Vector2

extension FloatVector where Self: Vector2 {

    public static var x: Self { return self.init(1, 0) }
    public static var y: Self { return self.init(0, 1) }
}

public protocol FloatVector3: FloatVector, Vector3 {

    /// Generic `cross` method declaration.
    func cross(_ y: Self) -> Self
}

extension FloatVector3 {

    public static var x: Self { return self.init(1, 0, 0) }
    public static var y: Self { return self.init(0, 1, 0) }
    public static var z: Self { return self.init(0, 0, 1) }
}

public typealias FloatVector4 = FloatVector & Vector4

extension FloatVector where Self: Vector4 {

    public static var x: Self { return self.init(1, 0, 0, 0) }
    public static var y: Self { return self.init(0, 1, 0, 0) }
    public static var z: Self { return self.init(0, 0, 1, 0) }
    public static var w: Self { return self.init(0, 0, 0, 1) }
}
