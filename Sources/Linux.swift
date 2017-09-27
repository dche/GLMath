//
// GLMath - Linux.swift
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

#if os(Linux)

import Glibc

extension NumericVector {

    public static func + (lhs: Self, rhs: Self) -> Self {
        return lhs.zip(rhs, +)
    }

    public static func * (lhs: Self, rhs: Self) -> Self {
        return lhs.zip(rhs, *)
    }

    public static func / (lhs: Self, rhs: Self) -> Self {
        return lhs.zip(rhs, /)
    }
}

extension NumericVector where Component: GenericSignedNumber {

    public var signum: Self {
        return self.map { $0.signum }
    }

    public static prefix func - (op: Self) -> Self {
        return op.map(-)
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        return lhs.zip(rhs, -)
    }
}

extension Vector2 where Component: Zero {

    public init (_ components: [Component]) {
        let x = components.count > 0 ? components[0] : Component.zero
        let y = components.count > 1 ? components[1] : Component.zero
        self.init(x, y)
    }
}

extension Vector3 where Component: Zero {

    public init (_ components: [Component]) {
        let x = components.count > 0 ? components[0] : Component.zero
        let y = components.count > 1 ? components[1] : Component.zero
        let z = components.count > 2 ? components[2] : Component.zero
        self.init(x, y, z)
    }
}

extension Vector4 where Component: Zero {

    public init (_ components: [Component]) {
        let x = components.count > 0 ? components[0] : Component.zero
        let y = components.count > 1 ? components[1] : Component.zero
        let z = components.count > 2 ? components[2] : Component.zero
        let w = components.count > 2 ? components[3] : Component.zero
        self.init(x, y, z, w)
    }
}

// MARK: Integer.

public struct IVec2<T: BaseInt>: IntVector, Vector2 {

    public typealias Dim = Dimension2
    public typealias Component = T

    public var x, y: T

    public init (_ x: T, _ y: T) {
        self.x = x
        self.y = y
    }
}

public typealias uvec2 = IVec2<UInt32>
public typealias ivec2 = IVec2<Int32>

public struct IVec3<T: BaseInt>: IntVector, Vector3 {

    public typealias Dim = Dimension3
    public typealias Component = T
    public typealias AssociatedVector2 = IVec2<T>

    public var x, y, z: T

    private var _w: T = 0

    public init (_ x: T, _ y: T, _ z: T) {
        self.x = x
        self.y = y
        self.z = z
    }
}

public typealias uvec3 = IVec3<UInt32>
public typealias ivec3 = IVec3<Int32>

public struct IVec4<T: BaseInt>: IntVector, Vector4 {

    public typealias Dim = Dimension4
    public typealias Component = T
    public typealias AssociatedVector2 = IVec2<T>
    public typealias AssociatedVector3 = IVec3<T>

    public var x, y, z, w: T

    public init (_ x: T, _ y: T, _ z: T, _ w: T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
}

public typealias uvec4 = IVec4<UInt32>
public typealias ivec4 = IVec4<Int32>

// MARK: Float point.

extension BaseFloat {

    public func step(_ edge: Self) -> Self {
        if self < edge { return .zero }
        return .one
    }
}

extension Float {

    public var fract: Float {
        return self - Glibc.floorf(self)
    }
    public var recip: Float {
        return 1.0 / self
    }
    public var rsqrt: Float {
        return 1.0 / Glibc.sqrtf(self)
    }

    public var sin: Float { return Glibc.sinf(self) }
    public var cos: Float { return Glibc.cosf(self) }
    public var acos: Float { return Glibc.acosf(self) }
    public var sqrt: Float { return Glibc.sqrtf(self) }
    public var frexp: (Float, Int) {
        var exp: Int32 = 0
        let frac = Glibc.frexpf(self, &exp)
        return (frac, Int(exp))
    }

    public func ldexp(_ exp: Int) -> Float {
        return Glibc.ldexpf(self, Int32(exp))
    }
}

extension Double {

    public var fract: Double {
        return self - Glibc.floor(self)
    }
    public var recip: Double {
        return 1.0 / self
    }
    public var rsqrt: Double {
        return 1.0 / Glibc.sqrt(self)
    }

    public var sin: Double { return Glibc.sin(self) }
    public var cos: Double { return Glibc.cos(self) }
    public var acos: Double { return Glibc.acos(self) }
    public var sqrt: Double { return Glibc.sqrt(self) }
    public var frexp: (Double, Int) {
        var exp: Int32 = 0
        let frac = Glibc.frexp(self, &exp)
        return (frac, Int(exp))
    }

    public func ldexp(_ exp: Int) -> Double {
        return Glibc.ldexp(self, Int32(exp))
    }
}

extension FloatVector {

    public var fract: Self { return self.map { $0.fract } }
    public var recip: Self { return self.map { $0.recip } }
    public var rsqrt: Self { return self.map { $0.rsqrt } }

    public func step(_ edge: Self) -> Self {
        return self.zip(edge) { $0.step($1) }
    }

    public var length: Component {
        return self.dot(self).sqrt
    }
    public var normalize: Self {
        let sqlen = self.dot(self)
        if sqlen == Component.zero { return self }
        let m = sqlen.rsqrt
        return self * m
    }
    public func distance(to other: Self) -> Component {
        return (self - other).length
    }
    public func mix(_ other: Self, t: Self) -> Self {
        return self * (Self.one - t) + other * t
    }
    public func smoothstep(_ edge0: Self, _ edge1: Self) -> Self {
        let t0: Self = (self - edge0) / (edge1 - edge0)
        let t: Self = t0.map {
            $0 < 0 ? 0 : ($0 > 1 ? 1 : $0)
        }
        return t * t * (t * -2 + 3)
    }
}

public struct Vec2<T: BaseFloat>: FloatVector2 {

    public typealias Dim = Dimension2
    public typealias Component = T
    public typealias InexactNumber = T
    public typealias InterpolatableNumber = T

    public var x, y: T

    public init (_ x: T, _ y: T) {
        self.x = x
        self.y = y
    }

    public func dot(_ other: Vec2<T>) -> T {
        return self.x * other.x + self.y * other.y
    }
}

public typealias vec2 = Vec2<Float>
public typealias dvec2 = Vec2<Double>

public struct Vec3<T: BaseFloat>: FloatVector3 {

    public typealias Dim = Dimension3
    public typealias Component = T
    public typealias InexactNumber = T
    public typealias InterpolatableNumber = T
    public typealias AssociatedVector2 = Vec2<T>

    public var x, y, z: T

    private var _w: T = 0

    public init (_ x: T, _ y: T, _ z: T) {
        self.x = x
        self.y = y
        self.z = z
    }

    public func dot(_ other: Vec3<T>) -> T {
        let x = self.x * other.x
        let y = self.y * other.y
        let z = self.z * other.z
        return x + y + z
    }

    public func cross(_ other: Vec3<T>) -> Vec3<T> {
        let cx = self.y * other.z - other.y * self.z
        let cy = self.z * other.x - other.z * self.x
        let cz = self.x * other.y - other.x * self.y
        return Vec3<T>(cx, cy, cz)
    }
}

public typealias vec3 = Vec3<Float>
public typealias dvec3 = Vec3<Double>

public struct Vec4<T: BaseFloat>: FloatVector4 {

    public typealias Dim = Dimension4
    public typealias Component = T
    public typealias InexactNumber = T
    public typealias InterpolatableNumber = T
    public typealias AssociatedVector2 = Vec2<T>
    public typealias AssociatedVector3 = Vec3<T>

    public var x, y, z, w: T

    public init (_ x: T, _ y: T, _ z: T, _ w: T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public func dot(_ other: Vec4<T>) -> T {
        let x = self.x * other.x
        let y = self.y * other.y
        let z = self.z * other.z
        let w = self.w * other.w
        return x + y + z + w
    }

    fileprivate func truncate(_ i: Int) -> Vec3<T> {
        switch i {
        case 0: return self.yzw
        case 1: return self.xzw
        case 2: return self.xyw
        default: return self.xyz
        }
    }
}

public typealias vec4 = Vec4<Float>
public typealias dvec4 = Vec4<Double>

// MARK: Matrix.

extension GenericMatrix {

    public subscript (column: Int, row: Int) -> Component.Component {
        return self[column][row]
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        return lhs.zip(rhs, +)
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        return lhs.zip(rhs, -)
    }

    public static func * (lhs: Self, rhs: Self.Component.Component) -> Self {
        return lhs.map { $0.map { $0 * rhs } }
    }
}

public struct Mat2x2<T: BaseFloat>: Vector2, GenericSquareMatrix {

    public typealias Component = Vec2<T>
    public typealias Dim = Dimension2
    public typealias InexactNumber = T
    public typealias InterpolatableNumber = T

    public var x, y: Component

    public init (_ x: Component, _ y: Component) {
        self.x = x
        self.y = y
    }

    public init (diagonal: Component) {
        self.x = Component.zero
        self.y = Component.zero
        self.x[0] = diagonal[0]
        self.y[1] = diagonal[1]
    }

    public var determinant: T {
        return self.x.x * self.y.y - self.x.y * self.y.x
    }

    public var inverse: Mat2x2<T> {
        let inv_det = Component(self.determinant.recip)
        let x = Component(self.y.y, -self.x.y) * inv_det
        let y = Component(self.y.x, self.x.x) * inv_det
        return Mat2x2<T>(x, y)
    }

    public var transpose: Mat2x2<T> {
        let x = Component(self.x.x, self.y.x)
        let y = Component(self.x.y, self.y.y)
        return Mat2x2<T>(x, y)
    }
}

public struct Mat2<T: FloatVector>: Vector2, GenericMatrix {

    public typealias Component = T
    public typealias Dim = Dimension2
    public typealias InexactNumber = T.Component
    public typealias InterpolatableNumber = T.Component

    public var x, y: T

    public init (_ x: T, _ y: T) {
        self.x = x
        self.y = y
    }
}

public typealias mat2 = Mat2x2<Float>
public typealias dmat2 = Mat2x2<Double>
public typealias mat2x2 = mat2
public typealias dmat2x2 = dmat2
public typealias mat2x3 = Mat2<vec3>
public typealias dmat2x3 = Mat2<dvec3>
public typealias mat2x4 = Mat2<vec4>
public typealias dmat2x4 = Mat2<dvec4>

public struct Mat3x3<T: BaseFloat>: Vector3, GenericSquareMatrix {

    public typealias Component = Vec3<T>
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = Mat2<Vec3<T>>
    public typealias InexactNumber = T
    public typealias InterpolatableNumber = T

    public var x, y, z: Component

    private var _w = Component.zero

    public init (_ x: Component, _ y: Component, _ z: Component) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init (diagonal: Component) {
        self.x = Component.zero
        self.y = Component.zero
        self.z = Component.zero
        self.x[0] = diagonal[0]
        self.y[1] = diagonal[1]
        self.z[2] = diagonal[2]
    }

    public var determinant: T {
        let a = self.y.y * self.z.z - self.z.y * self.y.z
        let x: T = self.x.x * a
        let b = self.x.y * self.z.z - self.z.y * self.x.z
        let y: T = self.y.x * b
        let c = self.x.y * self.y.z - self.y.y * self.x.z
        let z: T = self.z.x * c
        return  x - y + z
    }

    public var inverse: Mat3x3<T> {
        let inv_det = Component(self.determinant.recip)
        let r11 = self.y.y * self.z.z - self.z.y * self.y.z;
        let r12 = self.z.x * self.y.z - self.y.x * self.z.z;
        let r13 = self.y.x * self.z.y - self.z.x * self.y.y;
        let r21 = self.z.y * self.x.z - self.x.y * self.z.z;
        let r22 = self.x.x * self.z.z - self.z.x * self.x.z;
        let r23 = self.z.x * self.x.y - self.x.x * self.z.y;
        let r31 = self.x.y * self.y.z - self.y.y * self.x.z;
        let r32 = self.y.x * self.x.z - self.x.x * self.y.z;
        let r33 = self.x.x * self.y.y - self.y.x * self.x.y;
        let x = Component(r11, r21, r31) * inv_det
        let y = Component(r12, r22, r32) * inv_det
        let z = Component(r13, r23, r33) * inv_det
        return Mat3x3<T>(x, y, z)
    }

    public var transpose: Mat3x3<T> {
        let x = Component(self.x.x, self.y.x, self.z.x)
        let y = Component(self.x.y, self.y.y, self.z.y)
        let z = Component(self.x.y, self.y.y, self.z.z)
        return Mat3x3<T>(x, y, z)
    }
}

public struct Mat3<T: FloatVector>: Vector3, GenericMatrix {

    public typealias Component = T
    public typealias Dim = Dimension3
    public typealias AssociatedVector2 = Mat2<T>
    public typealias InexactNumber = T.Component
    public typealias InterpolatableNumber = T.Component

    public var x, y, z: T

    private var _w: T = T.zero

    public init (_ x: T, _ y: T, _ z: T) {
        self.x = x
        self.y = y
        self.z = z
    }
}

public typealias mat3 = Mat3x3<Float>
public typealias dmat3 = Mat3x3<Double>
public typealias mat3x3 = mat3
public typealias dmat3x3 = dmat3
public typealias mat3x2 = Mat3<vec2>
public typealias dmat3x2 = Mat3<dvec2>
public typealias mat3x4 = Mat3<vec4>
public typealias dmat3x4 = Mat3<dvec4>

public struct Mat4x4<T: BaseFloat>: Vector4, GenericSquareMatrix {

    public typealias Component = Vec4<T>
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = Mat2<Vec4<T>>
    public typealias AssociatedVector3 = Mat3<Vec4<T>>
    public typealias InexactNumber = T
    public typealias InterpolatableNumber = T

    public var x, y, z, w: Component

    public init (_ x: Component, _ y: Component, _ z: Component, _ w: Component) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init (diagonal: Component) {
        self.x = Component.zero
        self.y = Component.zero
        self.z = Component.zero
        self.w = Component.zero
        self.x[0] = diagonal[0]
        self.y[1] = diagonal[1]
        self.z[2] = diagonal[2]
        self.w[3] = diagonal[3]
    }

    public var determinant: T {
        var n0, n1, n2, n3, n4, n5, n6: T
        n0 = self.y.y * self.z.z * self.w.w
        n1 = self.z.y * self.w.z * self.y.w
        n2 = self.w.y * self.y.z * self.z.w
        n3 = self.w.y * self.z.z * self.y.w
        n4 = self.y.y * self.w.z * self.z.w
        n5 = self.z.y * self.y.z * self.w.w
        n6 = n0 + n1 + n2 - n3 - n4 - n5
        let x: T = self.x.x * n6

        n0 = self.x.y * self.z.z * self.w.w
        n1 = self.z.y * self.w.z * self.x.w
        n2 = self.w.y * self.x.z * self.z.w
        n3 = self.w.y * self.z.z * self.x.w
        n4 = self.x.y * self.w.z * self.z.w
        n5 = self.z.y * self.x.z * self.w.w
        n6 = n0 + n1 + n2 - n3 - n4 - n5
        let y: T = self.y.x * n6

        n0 = self.x.y * self.y.z * self.w.w
        n1 = self.y.y * self.w.z * self.x.w
        n2 = self.w.y * self.x.z * self.y.w
        n3 = self.w.y * self.y.z * self.x.w
        n4 = self.x.y * self.w.z * self.y.w
        n5 = self.y.y * self.x.z * self.w.w
        n6 = n0 + n1 + n2 - n3 - n4 - n5
        let z: T = self.z.x * n6

        n0 = self.x.y * self.y.z * self.z.w
        n1 = self.y.y * self.z.z * self.x.w
        n2 = self.z.y * self.x.z * self.y.w
        n3 = self.z.y * self.y.z * self.x.w
        n4 = self.x.y * self.z.z * self.y.w
        n5 = self.y.y * self.x.z * self.z.w
        n6 = n0 + n1 + n2 - n3 - n4 - n5
        let w: T = self.w.x * n6
        return x - y + z - w
    }

    public var inverse: Mat4x4<T> {
        let inv_det = self.determinant.recip
        let tr = self.transpose
        let cf: (Int, Int) -> T = { (i: Int, j: Int) in
            let x, y, z: Vec3<T>
            switch i {
            case 0:
                x = tr.y.truncate(j)
                y = tr.z.truncate(j)
                z = tr.w.truncate(j)
            case 1:
                x = tr.x.truncate(j)
                y = tr.z.truncate(j)
                z = tr.w.truncate(j)
            case 2:
                x = tr.x.truncate(j)
                y = tr.y.truncate(j)
                z = tr.w.truncate(j)
            default:
                x = tr.x.truncate(j)
                y = tr.y.truncate(j)
                z = tr.z.truncate(j)
            }
            let m = Mat3x3<T>(x, y, z)
            let d = m.determinant * inv_det
            if (i + j) & 1 == 1 { return -d }
            return d
        }
        let x = Component(cf(0, 0), cf(0, 1), cf(0, 2), cf(0, 3))
        let y = Component(cf(1, 0), cf(1, 1), cf(1, 2), cf(1, 3))
        let z = Component(cf(2, 0), cf(2, 1), cf(2, 2), cf(2, 3))
        let w = Component(cf(3, 0), cf(3, 1), cf(3, 2), cf(3, 3))
        return Mat4x4<T>(x, y, z, w)
    }

    public var transpose: Mat4x4<T> {
        let x = Component(self.x.x, self.y.x, self.z.x, self.w.x)
        let y = Component(self.x.y, self.y.y, self.z.y, self.w.y)
        let z = Component(self.x.z, self.y.z, self.z.z, self.w.z)
        let w = Component(self.x.w, self.y.w, self.z.w, self.w.w)
        return Mat4x4<T>(x, y, z, w)
    }
}

public struct Mat4<T: FloatVector>: Vector4, GenericMatrix {

    public typealias Component = T
    public typealias Dim = Dimension4
    public typealias AssociatedVector2 = Mat2<T>
    public typealias AssociatedVector3 = Mat3<T>
    public typealias InexactNumber = T.Component
    public typealias InterpolatableNumber = T.Component

    public var x, y, z, w: T

    public init (_ x: T, _ y: T, _ z: T, _ w: T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
}

public typealias mat4 = Mat4x4<Float>
public typealias dmat4 = Mat4x4<Double>
public typealias mat4x4 = mat4
public typealias dmat4x4 = dmat4
public typealias mat4x2 = Mat4<vec2>
public typealias dmat4x2 = Mat4<dvec2>
public typealias mat4x3 = Mat4<vec3>
public typealias dmat4x3 = Mat4<dvec3>

// MARK: Transpose.

extension Mat2 where T: FloatVector3 {

    public var transpose: Mat3<Vec2<T.Component>> {
        let x = Vec2<T.Component>(self.x.x, self.y.x)
        let y = Vec2<T.Component>(self.x.y, self.y.y)
        let z = Vec2<T.Component>(self.x.z, self.y.z)
        return Mat3<Vec2<T.Component>>(x, y, z)
    }
}

extension Mat2 where T: FloatVector4 {

    public var transpose: Mat4<Vec2<T.Component>> {
        let x = Vec2<T.Component>(self.x.x, self.y.x)
        let y = Vec2<T.Component>(self.x.y, self.y.y)
        let z = Vec2<T.Component>(self.x.z, self.y.z)
        let w = Vec2<T.Component>(self.x.w, self.y.w)
        return Mat4<Vec2<T.Component>>(x, y, z, w)
    }
}

extension Mat3 where T: FloatVector2 {

    public var transpose: Mat2<Vec3<T.Component>> {
        let x = Vec3<T.Component>(self.x.x, self.y.x, self.z.x)
        let y = Vec3<T.Component>(self.x.y, self.y.y, self.z.y)
        return Mat2<Vec3<T.Component>>(x, y)
    }
}

extension Mat3 where T: FloatVector4 {

    public var transpose: Mat4<Vec3<T.Component>> {
        let x = Vec3<T.Component>(self.x.x, self.y.x, self.z.x)
        let y = Vec3<T.Component>(self.x.y, self.y.y, self.z.y)
        let z = Vec3<T.Component>(self.x.z, self.y.z, self.z.z)
        let w = Vec3<T.Component>(self.x.w, self.y.w, self.z.w)
        return Mat4<Vec3<T.Component>>(x, y, z, w)
    }
}

extension Mat4 where T: FloatVector2 {

    public var transpose: Mat2<Vec4<T.Component>> {
        let x = Vec4<T.Component>(self.x.x, self.y.x, self.z.x, self.w.x)
        let y = Vec4<T.Component>(self.x.y, self.y.y, self.z.y, self.w.y)
        return Mat2<Vec4<T.Component>>(x, y)
    }
}

extension Mat4 where T: FloatVector3 {

    public var transpose: Mat3<Vec4<T.Component>> {
        let x = Vec4<T.Component>(self.x.x, self.y.x, self.z.x, self.w.x)
        let y = Vec4<T.Component>(self.x.y, self.y.y, self.z.y, self.w.y)
        let z = Vec4<T.Component>(self.x.z, self.y.z, self.z.z, self.w.z)
        return Mat3<Vec4<T.Component>>(x, y, z)
    }
}

// MARK: Matrix multiplication.

extension Mat2x2 {

    public static func * (lhs: Mat2x2<T>, rhs: Mat2x2<T>) -> Mat2x2<T> {
        let tr = lhs.transpose
        let x = Vec2<T>(rhs.x.dot(tr.x), rhs.x.dot(tr.y))
        let y = Vec2<T>(rhs.y.dot(tr.x), rhs.y.dot(tr.y))
        return Mat2x2<T>(x, y)
    }

    public static func * (lhs: Mat2x2<T>, rhs: Vec2<T>) -> Vec2<T> {
        let x = lhs.x.dot(rhs)
        let y = lhs.y.dot(rhs)
        return Vec2<T>(x, y)
    }
}

extension Mat3x3 {

    public static func * (lhs: Mat3x3<T>, rhs: Mat3x3<T>) -> Mat3x3<T> {
        let tr = lhs.transpose
        let x = Vec3<T>(tr.x.dot(rhs.x), tr.y.dot(rhs.x), tr.z.dot(rhs.x))
        let y = Vec3<T>(tr.x.dot(rhs.y), tr.y.dot(rhs.y), tr.z.dot(rhs.y))
        let z = Vec3<T>(tr.x.dot(rhs.z), tr.y.dot(rhs.z), tr.z.dot(rhs.z))
        return Mat3x3<T>(x, y, z)
    }

    public static func * (lhs: Mat3x3<T>, rhs: Vec3<T>) -> Vec3<T> {
        let x = lhs.x.dot(rhs)
        let y = lhs.y.dot(rhs)
        let z = lhs.z.dot(rhs)
        return Vec3<T>(x, y, z)
    }
}
extension Mat4x4 {

    public static func * (lhs: Mat4x4<T>, rhs: Mat4x4<T>) -> Mat4x4<T> {
        let tr = lhs.transpose
        let x = Vec4<T>(tr.x.dot(rhs.x), tr.y.dot(rhs.x), tr.z.dot(rhs.x), tr.w.dot(rhs.x))
        let y = Vec4<T>(tr.x.dot(rhs.y), tr.y.dot(rhs.y), tr.z.dot(rhs.y), tr.w.dot(rhs.y))
        let z = Vec4<T>(tr.x.dot(rhs.z), tr.y.dot(rhs.z), tr.z.dot(rhs.z), tr.w.dot(rhs.z))
        let w = Vec4<T>(tr.x.dot(rhs.w), tr.y.dot(rhs.w), tr.z.dot(rhs.w), tr.w.dot(rhs.w))
        return Mat4x4<T>(x, y, z, w)
    }

    public static func * (lhs: Mat4x4<T>, rhs: Vec4<T>) -> Vec4<T> {
        let x = lhs.x.dot(rhs)
        let y = lhs.y.dot(rhs)
        let z = lhs.z.dot(rhs)
        let w = lhs.w.dot(rhs)
        return Vec4<T>(x, y, z, w)
    }
}

// TODO: Non-square matrix multiplication.

#endif
