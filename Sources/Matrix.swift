//
// GLMath - Matrix.swift
//
// Matrix types.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import Darwin
import simd

/// Generic matrix type.
///
/// A matrix is treated as vector of vectors of float number.
public protocol GenericMatrix: Vector {

    associatedtype Component: FloatVector

    subscript (column: Int, row: Int) -> Component.Component { get }
}

/// Generic type of square matrices.
public protocol GenericSquareMatrix: GenericMatrix, One, Zero {

    associatedtype Dim = Component.Dim

    static var identity: Self { get }

    /// Returns the inverse of the receiver.
    var inverse: Self { get }

    /// Returns the determinant of a square matrix.
    var determinant: Component.Component { get }

    init (diagonal: Component)
}

public extension GenericMatrix {

    var x: Component {
        get { return self[0] }
        set { self[0] = newValue }
    }

    var y: Component {
        get { return self[1] }
        set { self[1] = newValue }
    }
}

public extension GenericMatrix where Self: Vector2 {

    init (_ x: Component, _ y: Component) {
        self.init([x, y])
    }
}

public extension GenericMatrix where Self: Vector3 {

    var z: Component {
        get { return self[2] }
        set { self[2] = newValue }
    }

    init (_ x: Component, _ y: Component, _ z: Component) {
        self.init([x, y, z])
    }
}

public extension GenericMatrix where Self: Vector4 {

    var z: Component {
        get { return self[2] }
        set { self[2] = newValue }
    }

    var w: Component {
        get { return self[3] }
        set { self[3] = newValue }
    }

    init (_ x: Component, _ y: Component, _ z: Component, _ w: Component) {
        self.init([x, y, z, w])
    }
}

// MARK: GenericSquareMatrix

public extension GenericSquareMatrix {

    static var identity: Self {
        return self.init(diagonal: Component.one)
    }

    static var one: Self { return identity }

    static var zero: Self {
        return self.init(diagonal: Component.zero)
    }
}

public extension GenericSquareMatrix where Self: Vector2, Self.Component: FloatVector2 {

    var determinant: Component.Component {
        return x.x * y.y - x.y * y.x
    }
}

public extension GenericSquareMatrix where Self: Vector3, Self.Component: FloatVector3 {

    var determinant: Component.Component {
        let a = x.x * (y.y * z.z - z.y * y.z)
        let b = y.x * (x.y * z.z - z.y * x.z)
        let c = z.x * (x.y * y.z - y.y * x.z)
        return a - b + c
    }
}

extension float2x2: Vector2, GenericSquareMatrix {

    public typealias Component = vec2
    public typealias Dim = Dimension2
}

public typealias mat2 = float2x2
public typealias mat2x2 = mat2

extension float2x3: Vector2, GenericMatrix {

    public typealias Component = vec3
    public typealias Dim = Dimension2
}

public typealias mat2x3 = float2x3

extension float2x4: Vector2, GenericMatrix {

    public typealias Component = vec4
    public typealias Dim = Dimension2
}

public typealias mat2x4 = float2x4

extension double2x2: Vector2, GenericSquareMatrix {

    public typealias Component = dvec2
    public typealias Dim = Dimension2
}

public typealias dmat2 = double2x2
public typealias dmat2x2 = dmat2

extension double2x3: Vector2, GenericMatrix {

    public typealias Component = dvec3
    public typealias Dim = Dimension2
}

public typealias dmat2x3 = double2x3

extension double2x4: Vector2, GenericMatrix {

    public typealias Component = dvec4
    public typealias Dim = Dimension2
}

public typealias dmat2x4 = double2x4

extension float3x3: Vector3, GenericSquareMatrix {

    public typealias Component = vec3
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = float2x3
}

public typealias mat3 = float3x3
public typealias mat3x3 = mat3

extension float3x2: Vector3, GenericMatrix {

    public typealias Component = vec2
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = float2x2
}

public typealias mat3x2 = float3x2

extension float3x4: Vector3, GenericMatrix {

    public typealias Component = vec4
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = float2x4
}

public typealias mat3x4 = float3x4

extension double3x3: Vector3, GenericSquareMatrix {

    public typealias Component = dvec3
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = double2x3
}

public typealias dmat3 = double3x3
public typealias dmat3x3 = dmat3

extension double3x2: Vector3, GenericMatrix {

    public typealias Component = dvec2
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = double2x2
}

public typealias dmat3x2 = double3x2

extension double3x4: Vector3, GenericMatrix {

    public typealias Component = dvec4
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = double2x4
}

public typealias dmat3x4 = double3x4

extension float4x4: Vector4, GenericSquareMatrix {

    public typealias Component = vec4
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = float2x4
    public typealias AssociatedVector3 = float3x4

    public var determinant: Float {
        return simd.matrix_determinant(self.cmatrix)
    }
}

public typealias mat4 = float4x4
public typealias mat4x4 = mat4

extension float4x2: Vector4, GenericMatrix {

    public typealias Component = vec2
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = float2x2
    public typealias AssociatedVector3 = float3x2
}

public typealias mat4x2 = float4x2

extension float4x3: Vector4, GenericMatrix {

    public typealias Component = vec3
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = float2x3
    public typealias AssociatedVector3 = float3x3
}

public typealias mat4x3 = float4x3

extension double4x4: Vector4, GenericSquareMatrix {

    public typealias Component = dvec4
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = double2x4
    public typealias AssociatedVector3 = double3x4

    public var determinant: Double {
        return simd.matrix_determinant(self.cmatrix)
    }
}

public typealias dmat4 = double4x4
public typealias dmat4x4 = dmat4

extension double4x2: Vector4, GenericMatrix {

    public typealias Component = dvec2
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = double2x2
    public typealias AssociatedVector3 = double3x2
}

public typealias dmat4x2 = double4x2

extension double4x3: Vector4, GenericMatrix {

    public typealias Component = dvec3
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = double2x3
    public typealias AssociatedVector3 = double3x3
}

public typealias dmat4x3 = double4x3
