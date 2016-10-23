//
// GLMath - Float.swift
//
// Float scalar and vector types.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import Darwin
import simd

// NOTE: There are lots of glue code in this file. They are needed to make the
//       interface generic.

/// Generic float number type.
public protocol GenericFloat: GenericSignedNumber, ApproxEquatable {

    var fract: Self { get }
    var recip: Self { get }
    var rsqrt: Self { get }

    func step(_ edge: Self) -> Self
}

/// Primitive float number type.
public protocol BaseFloat: BaseNumber, GenericFloat, FloatingPoint, ExpressibleByFloatLiteral {

    var frexp: (Self, Int) { get }
    func ldexp(_ exp: Int) -> Self
}

extension BaseFloat {

    public typealias NumberType = Self

    public func isClose(to other: Self, tolerance: Self = Self.epsilon) -> Bool {
        if other.isZero {
            return abs(self) <= tolerance
        }
        let diff = abs(self - other)
        let m = max(abs(self), abs(other))
        return diff <= m * tolerance
    }
}

extension Float: BaseFloat {

    public static let zero: Float = 0
    public static let one: Float = 1

    public var fract: Float { return self - simd.floor(self) }
    public var frexp: (Float, Int) { return simd.frexp(self) }
    public var recip: Float { return simd.recip(self) }
    public var rsqrt: Float { return simd.rsqrt(self) }

    public func ldexp(_ exp: Int) -> Float { return simd.ldexp(self, exp) }
    public func step(_ edge: Float) -> Float { return simd.step(self, edge: edge) }
}

extension Double: BaseFloat {

    public static let zero: Double = 0
    public static let one: Double = 1

    public var fract: Double { return self - simd.floor(self) }
    public var frexp: (Double, Int) { return simd.frexp(self) }
    public var recip: Double { return simd.recip(self) }
    public var rsqrt: Double { return simd.rsqrt(self) }

    public func ldexp(_ exp: Int) -> Double { return simd.ldexp(self, exp) }
    public func step(_ edge: Double) -> Double { return simd.step(self, edge: edge) }
}

/// Float number vector.
public protocol FloatVector: NumberVector, GenericFloat {

    associatedtype Component: BaseFloat

    var length: Component { get }
    var normalize: Self { get }

    func distance(to y: Self) -> Component
    func dot(_ y: Self) -> Component
    func mix(_ y: Self, t: Self) -> Self
    func smoothstep(_ edge0: Self, _ edge1: Self) -> Self
}

extension FloatVector {

    public static func / (lhs: Self, rhs: Component) -> Self {
        return lhs * rhs.recip
    }
}

extension FloatVector where Component.NumberType == Component {

    public typealias NumberType = Component

    public func isClose(to other: Self, tolerance: Component = .epsilon) -> Bool {
        for i in 0 ..< Self.dimension {
            guard self[i].isClose(to: other[i], tolerance: tolerance) else {
                return false
            }
        }
        return true
    }
}

public typealias FloatVector2 = FloatVector & Vector2
public typealias FloatVector3 = FloatVector & Vector3
public typealias FloatVector4 = FloatVector & Vector4

public typealias vec2 = float2

extension float2: FloatVector2 {

    public typealias Dim = Dimension2
    public typealias Component = Float

    public var fract: float2 { return simd.fract(self) }
    public var recip: float2 { return simd.recip(self) }
    public var rsqrt: float2 { return simd.rsqrt(self) }
    public var length: Float { return simd.length(self) }
    public var normalize: float2 { return simd.normalize(self) }

    public func distance(to y: float2) -> Float {
        return simd.distance(self, y)
    }

    public func dot(_ y: float2) -> Float {
        return simd.dot(self, y)
    }
    public func mix(_ y: float2, t: float2) -> float2 {
        return simd.mix(self, y, t: t)
    }
    public func step(_ edge: float2) -> float2 { return simd.step(self, edge: edge) }
    public func smoothstep(_ edge0: float2, _ edge1: float2) -> float2 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}

public typealias vec3 = float3

extension float3: FloatVector3 {

    public typealias Dim = Dimension3
    public typealias Component = Float
    public typealias AssociatedVector2 = float2

    public var fract: float3 { return simd.fract(self) }
    public var recip: float3 { return simd.recip(self) }
    public var rsqrt: float3 { return simd.rsqrt(self) }
    public var length: Float { return simd.length(self) }
    public var normalize: float3 { return simd.normalize(self) }

    public func distance(to y: float3) -> Float {
        return simd.distance(self, y)
    }

    public func dot(_ y: float3) -> Float {
        return simd.dot(self, y)
    }
    public func mix(_ y: float3, t: float3) -> float3 {
        return simd.mix(self, y, t: t)
    }
    public func step(_ edge: float3) -> float3 { return simd.step(self, edge: edge) }
    public func smoothstep(_ edge0: float3, _ edge1: float3) -> float3 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}

public typealias vec4 = float4

extension float4: FloatVector4 {

    public typealias Dim = Dimension4
    public typealias Component = Float
    public typealias AssociatedVector2 = float2
    public typealias AssociatedVector3 = float3

    public var fract: float4 { return simd.fract(self) }
    public var recip: float4 { return simd.recip(self) }
    public var rsqrt: float4 { return simd.rsqrt(self) }
    public var length: Float { return simd.length(self) }
    public var normalize: float4 { return simd.normalize(self) }

    public func distance(to y: float4) -> Float {
        return simd.distance(self, y)
    }

    public func dot(_ y: float4) -> Float {
        return simd.dot(self, y)
    }
    public func mix(_ y: float4, t: float4) -> float4 {
        return simd.mix(self, y, t: t)
    }
    public func step(_ edge: float4) -> float4 { return simd.step(self, edge: edge) }
    public func smoothstep(_ edge0: float4, _ edge1: float4) -> float4 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}

public typealias dvec2 = double2

extension double2: FloatVector2 {

    public typealias Dim = Dimension2
    public typealias Component = Double

    public var fract: double2 { return simd.fract(self) }
    public var recip: double2 { return simd.recip(self) }
    public var rsqrt: double2 { return simd.rsqrt(self) }
    public var length: Double { return simd.length(self) }
    public var normalize: double2 { return simd.normalize(self) }

    public func distance(to y: double2) -> Double {
        return simd.distance(self, y)
    }

    public func dot(_ y: double2) -> Double {
        return simd.dot(self, y)
    }
    public func mix(_ y: double2, t: double2) -> double2 {
        return simd.mix(self, y, t: t)
    }
    public func step(_ edge: double2) -> double2 { return simd.step(self, edge: edge) }
    public func smoothstep(_ edge0: double2, _ edge1: double2) -> double2 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}

public typealias dvec3 = double3

extension double3: FloatVector3 {

    public typealias Dim = Dimension3
    public typealias Component = Double
    public typealias AssociatedVector2 = double2

    public var fract: double3 { return simd.fract(self) }
    public var recip: double3 { return simd.recip(self) }
    public var rsqrt: double3 { return simd.rsqrt(self) }
    public var length: Double { return simd.length(self) }
    public var normalize: double3 { return simd.normalize(self) }

    public func distance(to y: double3) -> Double {
        return simd.distance(self, y)
    }

    public func dot(_ y: double3) -> Double {
        return simd.dot(self, y)
    }
    public func mix(_ y: double3, t: double3) -> double3 {
        return simd.mix(self, y, t: t)
    }
    public func step(_ edge: double3) -> double3 { return simd.step(self, edge: edge) }
    public func smoothstep(_ edge0: double3, _ edge1: double3) -> double3 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}

public typealias dvec4 = double4

extension double4: FloatVector4 {

    public typealias Dim = Dimension4
    public typealias Component = Double
    public typealias AssociatedVector2 = double2
    public typealias AssociatedVector3 = double3

    public var fract: double4 { return simd.fract(self) }
    public var recip: double4 { return simd.recip(self) }
    public var rsqrt: double4 { return simd.rsqrt(self) }
    public var length: Double { return simd.length(self) }
    public var normalize: double4 { return simd.normalize(self) }

    public func distance(to y: double4) -> Double {
        return simd.distance(self, y)
    }

    public func dot(_ y: double4) -> Double {
        return simd.dot(self, y)
    }
    public func mix(_ y: double4, t: double4) -> double4 {
        return simd.mix(self, y, t: t)
    }
    public func step(_ edge: double4) -> double4 { return simd.step(self, edge: edge) }
    public func smoothstep(_ edge0: double4, _ edge1: double4) -> double4 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}
