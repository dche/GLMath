//
// GLMath - SIMD.swift
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

#if !os(Linux)

// NOTE: On Apple's platforms, piggyback on SIMD module to implement most
//       computations effciently.

import Darwin
import simd

// MARK: Integer.

public typealias uvec2 = uint2

extension uint2: IntVector, Vector2 {

    public typealias Dim = Dimension2
    public typealias Component = UInt32

    public static func + (lhs: uint2, rhs: uint2) -> uint2 {
        return lhs &+ rhs
    }

    public static func * (lhs: uint2, rhs: uint2) -> uint2 {
        return lhs &* rhs
    }

    // SWIFT BUG:
    // Implementation in the extension of `NumericVector` is
    // not used (But for `+` it works). Why?

    public static func * (lhs: uint2, rhs: UInt32) -> uint2 {
        return lhs &* rhs
    }

    public static func * (lhs: UInt32, rhs: uint2) -> uint2 {
        return lhs &* rhs
    }
}

public typealias uvec3 = uint3

extension uint3: IntVector, Vector3 {

    public typealias Dim = Dimension3
    public typealias Component = UInt32
    public typealias AssociatedVector2 = uvec2

    public static func + (lhs: uint3, rhs: uint3) -> uint3 {
        return lhs &+ rhs
    }

    public static func * (lhs: uint3, rhs: uint3) -> uint3 {
        return lhs &* rhs
    }

    public static func * (lhs: uint3, rhs: UInt32) -> uint3 {
        return lhs &* rhs
    }

    public static func * (lhs: UInt32, rhs: uint3) -> uint3 {
        return lhs &* rhs
    }
}

public typealias uvec4 = uint4

extension uint4: IntVector, Vector4 {

    public typealias Dim = Dimension4
    public typealias Component = UInt32
    public typealias AssociatedVector2 = uvec2
    public typealias AssociatedVector3 = uvec3

    public static func + (lhs: uint4, rhs: uint4) -> uint4 {
        return lhs &+ rhs
    }

    public static func * (lhs: uint4, rhs: uint4) -> uint4 {
        return lhs &* rhs
    }

    public static func * (lhs: uint4, rhs: UInt32) -> uint4 {
        return lhs &* rhs
    }

    public static func * (lhs: UInt32, rhs: uint4) -> uint4 {
        return lhs &* rhs
    }
}

extension IntVector
    where
    Self: GenericSignedNumber,
    Component: GenericSignedNumber
{
    public var signum: Self {
        return self.map { $0.signum }
    }
}

public typealias ivec2 = int2

extension int2: IntVector, Vector2, GenericSignedNumber {

    public typealias Dim = Dimension2
    public typealias Component = Int32

    public static func + (lhs: int2, rhs: int2) -> int2 {
        return lhs &+ rhs
    }

    public static func - (lhs: int2, rhs: int2) -> int2 {
        return lhs &- rhs
    }

    public static func * (lhs: int2, rhs: int2) -> int2 {
        return lhs &* rhs
    }

    public static func * (lhs: int2, rhs: Int32) -> int2 {
        return lhs &* rhs
    }

    public static func * (lhs: Int32, rhs: int2) -> int2 {
        return lhs &* rhs
    }
}

public typealias ivec3 = int3

extension int3: IntVector, Vector3, GenericSignedNumber {

    public typealias Dim = Dimension3
    public typealias Component = Int32
    public typealias AssociatedVector2 = int2

    public static func + (lhs: int3, rhs: int3) -> int3 {
        return lhs &+ rhs
    }

    public static func -(lhs: int3, rhs: int3) -> int3 {
        return lhs &- rhs
    }

    public static func * (lhs: int3, rhs: int3) -> int3 {
        return lhs &* rhs
    }

    public static func * (lhs: int3, rhs: Int32) -> int3 {
        return lhs &* rhs
    }

    public static func * (lhs: Int32, rhs: int3) -> int3 {
        return lhs &* rhs
    }
}

public typealias ivec4 = int4

extension int4: IntVector, Vector4, GenericSignedNumber {

    public typealias Dim = Dimension4
    public typealias Component = Int32
    public typealias AssociatedVector2 = int2
    public typealias AssociatedVector3 = int3

    public static func + (lhs: int4, rhs: int4) -> int4 {
        return lhs &+ rhs
    }

    public static func -(lhs: int4, rhs: int4) -> int4 {
        return lhs &- rhs
    }

    public static func * (lhs: int4, rhs: int4) -> int4 {
        return lhs &* rhs
    }

    public static func * (lhs: int4, rhs: Int32) -> int4 {
        return lhs &* rhs
    }

    public static func * (lhs: Int32, rhs: int4) -> int4 {
        return lhs &* rhs
    }
}

// MARK: Flaot point.

extension Float {

    public var fract: Float { return self - simd.floor(self) }
    public var recip: Float { return simd.recip(self) }
    public var rsqrt: Float { return simd.rsqrt(self) }

    public var sin: Float { return Darwin.sin(self) }
    public var cos: Float { return Darwin.cos(self) }
    public var acos: Float { return Darwin.acos(self) }
    public var sqrt: Float { return Darwin.sqrt(self) }
    public var frexp: (Float, Int) { return simd.frexp(self) }

    public func ldexp(_ exp: Int) -> Float {
        return simd.ldexp(self, exp)
    }
    public func step(_ edge: Float) -> Float {
        return simd.step(self, edge: edge)
    }
}

extension Double {

    public var fract: Double { return self - simd.floor(self) }
    public var recip: Double { return simd.recip(self) }
    public var rsqrt: Double { return simd.rsqrt(self) }

    public var sin: Double { return Darwin.sin(self) }
    public var cos: Double { return Darwin.cos(self) }
    public var acos: Double { return Darwin.acos(self) }
    public var sqrt: Double { return Darwin.sqrt(self) }
    public var frexp: (Double, Int) { return simd.frexp(self) }

    public func ldexp(_ exp: Int) -> Double {
        return simd.ldexp(self, exp)
    }
    public func step(_ edge: Double) -> Double {
        return simd.step(self, edge: edge)
    }
}

public typealias vec2 = float2

extension float2: FloatVector2 {

    public typealias Dim = Dimension2
    public typealias Component = Float
    public typealias InexactNumber = Float
    public typealias InterpolatableNumber = Float

    public var signum: float2 { return simd.sign(self) }

    public var fract: float2 { return simd.fract(self) }
    public var recip: float2 { return simd.recip(self) }
    public var rsqrt: float2 { return simd.rsqrt(self) }

    public func step(_ edge: float2) -> float2 {
        return simd.step(self, edge: edge)
    }

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
    public func smoothstep(_ edge0: float2, _ edge1: float2) -> float2 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}

public typealias vec3 = float3

extension float3: FloatVector3 {

    public typealias Dim = Dimension3
    public typealias Component = Float
    public typealias AssociatedVector2 = float2
    public typealias InexactNumber = Float
    public typealias InterpolatableNumber = Float

    public var signum: float3 { return simd.sign(self) }

    public var fract: float3 { return simd.fract(self) }
    public var recip: float3 { return simd.recip(self) }
    public var rsqrt: float3 { return simd.rsqrt(self) }

    public func step(_ edge: float3) -> float3 {
        return simd.step(self, edge: edge)
    }

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
    public func smoothstep(_ edge0: float3, _ edge1: float3) -> float3 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
    public func cross(_ y: float3) -> float3 {
        return simd.cross(self, y)
    }
}

public typealias vec4 = float4

extension float4: FloatVector4 {

    public typealias Dim = Dimension4
    public typealias Component = Float
    public typealias AssociatedVector2 = float2
    public typealias AssociatedVector3 = float3
    public typealias InexactNumber = Float
    public typealias InterpolatableNumber = Float

    public var signum: float4 { return simd.sign(self) }

    public var fract: float4 { return simd.fract(self) }
    public var recip: float4 { return simd.recip(self) }
    public var rsqrt: float4 { return simd.rsqrt(self) }

    public func step(_ edge: float4) -> float4 {
        return simd.step(self, edge: edge)
    }

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
    public func smoothstep(_ edge0: float4, _ edge1: float4) -> float4 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}

public typealias dvec2 = double2

extension double2: FloatVector2 {

    public typealias Dim = Dimension2
    public typealias Component = Double
    public typealias InexactNumber = Double
    public typealias InterpolatableNumber = Double

    public var signum: double2 { return simd.sign(self) }

    public var fract: double2 { return simd.fract(self) }
    public var recip: double2 { return simd.recip(self) }
    public var rsqrt: double2 { return simd.rsqrt(self) }

    public func step(_ edge: double2) -> double2 {
        return simd.step(self, edge: edge)
    }

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
    public func smoothstep(_ edge0: double2, _ edge1: double2) -> double2 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}

public typealias dvec3 = double3

extension double3: FloatVector3 {

    public typealias Dim = Dimension3
    public typealias Component = Double
    public typealias AssociatedVector2 = double2
    public typealias InexactNumber = Double
    public typealias InterpolatableNumber = Double

    public var signum: double3 { return simd.sign(self) }

    public var fract: double3 { return simd.fract(self) }
    public var recip: double3 { return simd.recip(self) }
    public var rsqrt: double3 { return simd.rsqrt(self) }

    public func step(_ edge: double3) -> double3 {
        return simd.step(self, edge: edge)
    }

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
    public func smoothstep(_ edge0: double3, _ edge1: double3) -> double3 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
    public func cross(_ y: double3) -> double3 {
        return simd.cross(self, y)
    }
}

public typealias dvec4 = double4

extension double4: FloatVector4 {

    public typealias Dim = Dimension4
    public typealias Component = Double
    public typealias AssociatedVector2 = double2
    public typealias AssociatedVector3 = double3
    public typealias InexactNumber = Double
    public typealias InterpolatableNumber = Double

    public var signum: double4 { return simd.sign(self) }

    public var fract: double4 { return simd.fract(self) }
    public var recip: double4 { return simd.recip(self) }
    public var rsqrt: double4 { return simd.rsqrt(self) }

    public func step(_ edge: double4) -> double4 {
        return simd.step(self, edge: edge)
    }

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
    public func smoothstep(_ edge0: double4, _ edge1: double4) -> double4 {
        return simd.smoothstep(self, edge0: edge0, edge1: edge1)
    }
}

// MARK: Matrix.

extension float2x2: Vector2, GenericSquareMatrix {

    public typealias Component = vec2
    public typealias Dim = Dimension2
    public typealias InexactNumber = Float
}

public typealias mat2 = float2x2
public typealias mat2x2 = mat2

extension float2x3: Vector2, GenericMatrix {

    public typealias Component = vec3
    public typealias Dim = Dimension2
    public typealias InexactNumber = Float
}

public typealias mat2x3 = float2x3

extension float2x4: Vector2, GenericMatrix {

    public typealias Component = vec4
    public typealias Dim = Dimension2
    public typealias InexactNumber = Float
}

public typealias mat2x4 = float2x4

extension double2x2: Vector2, GenericSquareMatrix {

    public typealias Component = dvec2
    public typealias Dim = Dimension2
    public typealias InexactNumber = Double
}

public typealias dmat2 = double2x2
public typealias dmat2x2 = dmat2

extension double2x3: Vector2, GenericMatrix {

    public typealias Component = dvec3
    public typealias Dim = Dimension2
    public typealias InexactNumber = Double
}

public typealias dmat2x3 = double2x3

extension double2x4: Vector2, GenericMatrix {

    public typealias Component = dvec4
    public typealias Dim = Dimension2
    public typealias InexactNumber = Double
}

public typealias dmat2x4 = double2x4

extension float3x3: Vector3, GenericSquareMatrix {

    public typealias Component = vec3
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = float2x3
    public typealias InexactNumber = Float
}

public typealias mat3 = float3x3
public typealias mat3x3 = mat3

extension float3x2: Vector3, GenericMatrix {

    public typealias Component = vec2
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = float2x2
    public typealias InexactNumber = Float
}

public typealias mat3x2 = float3x2

extension float3x4: Vector3, GenericMatrix {

    public typealias Component = vec4
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = float2x4
    public typealias InexactNumber = Float
}

public typealias mat3x4 = float3x4

extension double3x3: Vector3, GenericSquareMatrix {

    public typealias Component = dvec3
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = double2x3
    public typealias InexactNumber = Double
}

public typealias dmat3 = double3x3
public typealias dmat3x3 = dmat3

extension double3x2: Vector3, GenericMatrix {

    public typealias Component = dvec2
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = double2x2
    public typealias InexactNumber = Double
}

public typealias dmat3x2 = double3x2

extension double3x4: Vector3, GenericMatrix {

    public typealias Component = dvec4
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = double2x4
    public typealias InexactNumber = Double
}

public typealias dmat3x4 = double3x4

extension float4x4: Vector4, GenericSquareMatrix {

    public typealias Component = vec4
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = float2x4
    public typealias AssociatedVector3 = float3x4
    public typealias InexactNumber = Float
}

public typealias mat4 = float4x4
public typealias mat4x4 = mat4

extension float4x2: Vector4, GenericMatrix {

    public typealias Component = vec2
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = float2x2
    public typealias AssociatedVector3 = float3x2
    public typealias InexactNumber = Float
}

public typealias mat4x2 = float4x2

extension float4x3: Vector4, GenericMatrix {

    public typealias Component = vec3
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = float2x3
    public typealias AssociatedVector3 = float3x3
    public typealias InexactNumber = Float
}

public typealias mat4x3 = float4x3

extension double4x4: Vector4, GenericSquareMatrix {

    public typealias Component = dvec4
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = double2x4
    public typealias AssociatedVector3 = double3x4
    public typealias InexactNumber = Double
}

public typealias dmat4 = double4x4
public typealias dmat4x4 = dmat4

extension double4x2: Vector4, GenericMatrix {

    public typealias Component = dvec2
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = double2x2
    public typealias AssociatedVector3 = double3x2
    public typealias InexactNumber = Double
}

public typealias dmat4x2 = double4x2

extension double4x3: Vector4, GenericMatrix {

    public typealias Component = dvec3
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = double2x3
    public typealias AssociatedVector3 = double3x3
    public typealias InexactNumber = Double
}

public typealias dmat4x3 = double4x3

#endif
