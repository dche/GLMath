//
// GLMath - Int.swift
//
// Integer scalars and vectors.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import simd

// TODO: Review all integer related code after SE-104 (Improved Integers)
//       is implemented.

public protocol GenericInt: GenericNumber {}

public protocol BaseInt: GenericInt, BaseNumber, Integer {
    init (_ i: UInt)
    static func >> (lhs: Self, rhs: Self) -> Self
}

extension Int32: BaseInt, GenericSignedNumber {

    public static let zero: Int32 = 0
    public static let one: Int32 = 1

    public var nextPow2: Int32 {
        let s = sign(self)
        let u = UInt32(abs(self)).nextPow2
        return Int32(u) * s
    }
}

extension UInt32: BaseInt {

    public static let zero: UInt32 = 0
    public static let one: UInt32 = 1

    public var nextPow2: UInt32 {
        var v = self - 1
        v |= self >> 1
        v |= self >> 2
        v |= self >> 3
        v |= self >> 8
        v |= self >> 16
        return v + 1
    }
}

public protocol IntVector: GenericInt, NumberVector {
    associatedtype Component: BaseInt
}

public typealias uvec2 = uint2

extension uint2: IntVector, Vector2 {

    public typealias Dim = Dimension2
    public typealias Component = UInt32
}

public typealias uvec3 = uint3

extension uint3: IntVector, Vector3 {

    public typealias Dim = Dimension3
    public typealias Component = UInt32
    public typealias AssociatedVector2 = uvec2
}

public typealias uvec4 = uint4

extension uint4: IntVector, Vector4 {

    public typealias Dim = Dimension4
    public typealias Component = UInt32
    public typealias AssociatedVector2 = uvec2
    public typealias AssociatedVector3 = uvec3
}

public typealias ivec2 = int2

extension int2: IntVector, Vector2, GenericSignedNumber {

    public typealias Dim = Dimension2
    public typealias Component = Int32

    public static func - (lhs: int2, rhs: int2) -> int2 {
        return lhs &- rhs
    }
}

public typealias ivec3 = int3

extension int3: IntVector, Vector3, GenericSignedNumber {

    public typealias Dim = Dimension3
    public typealias Component = Int32
    public typealias AssociatedVector2 = int2

    public static func -(lhs: int3, rhs: int3) -> int3 {
        return lhs &- rhs
    }
}

public typealias ivec4 = int4

extension int4: IntVector, Vector4, GenericSignedNumber {

    public typealias Dim = Dimension4
    public typealias Component = Int32
    public typealias AssociatedVector2 = int2
    public typealias AssociatedVector3 = int3
}
