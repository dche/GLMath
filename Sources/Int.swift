//
// GLMath - Int.swift
//
// Integer scalars and vectors.
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

public protocol BaseInt: BaseNumber, FixedWidthInteger {
    init (_ i: UInt)
}

extension Int32: BaseInt, GenericSignedNumber {

    public static let zero: Int32 = 0
    public static let one: Int32 = 1

    // SWIFT EVOLUTION: `Int32::signum()` might be changed to a property.
    public var signum: Int32 {
        return self.signum()
    }
}

extension UInt32: BaseInt {

    public static let zero: UInt32 = 0
    public static let one: UInt32 = 1

    public var nextPowerOf2: UInt32 {
        var v = self - 1
        v |= self >> 1
        v |= self >> 2
        v |= self >> 3
        v |= self >> 8
        v |= self >> 16
        return v + 1
    }
}

public protocol IntVector: NumericVector where Component: BaseInt {}
