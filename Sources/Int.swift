//
// GLMath - Int.swift
//
// Integer scalars and vectors.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

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
