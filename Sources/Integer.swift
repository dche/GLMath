//
// GLMath - Integer.swift
//
// GLSLangSpec 8.8 Integer Functions
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import Darwin

func map2
<
    T: NumberVector,
    C
>(_ x: T, _ y: T, _ fn: (C, C) -> (C, C)) -> (T, T)
    where
    C == T.Component
 {
    var a = T(C.zero)
    var b = a
    for i in 0 ..< T.dimension {
        let (l, r) = fn(x[i], y[i])
        a[i] = l
        b[i] = r
    }
    return (a, b)
}

/// Adds 32-bit unsigned integer `x` and `y`, returning the sum modulus
/// *2<sup>32</sup>* and the carry bit.
///
/// Carry is set to `0` if the sum was less than *2<sup>32</sup>*, or to `1`
/// otherwise.
///
/// - note:
/// In GLSL, the carry bit is returned via the output parameter `carry`.
public func uaddCarry(_ x: UInt32, _ y: UInt32) -> (UInt32, carry: UInt32) {
    let (s, o) = UInt32.addWithOverflow(x, y)
    if o { return (s, 1) }
    else { return (s, 0) }
}

/// Adds 32-bit unsigned integer `x` and `y`, returning the sum modulus
/// *2<sup>32</sup>* and the carry bit.
///
/// Carry is set to `0` if the sum was less than *2<sup>32</sup>*, or to `1`
/// otherwise.
///
/// - note:
/// In GLSL, the carry bit is returned via the output parameter `carry`.
public func uaddCarry<T: NumberVector>(_ x: T, _ y: T) -> (T, carry: T)
    where
    T.Component == UInt32
{
    return map2(x, y, uaddCarry)
}

/// Subtracts the 32-bit unsigned integer `y` from `x`, returning the
/// difference and the borrow bit.
///
/// Returns the difference if it is non-negative, or *2<sup>32</sup>* plus the
/// difference otherwise.
///
/// The borrow bit is set to `0` if` x ≥ y`, or to `1` otherwise.
public func usubBorrow(_ x: UInt32, _ y: UInt32) -> (UInt32, borrow: UInt32) {
    guard y > x else {
        return (x - y, 0)
    }
    return (0xFFFFFFFF - y + x, 1)
}

/// Subtracts the 32-bit unsigned integer `y` from `x`, returning the
/// difference and the borrow bit.
///
/// Returns the difference if it is non-negative, or *2<sup>32</sup>* plus the
/// difference otherwise.
///
/// The borrow bit is set to `0` if` x ≥ y`, or to `1` otherwise.
public func usubBorrow<T: NumberVector>(_ x: T, _ y: T) -> (T, borrow: T)
    where
    T.Component == UInt32
{
    return map2(x, y, usubBorrow)
}

/// Multiplies 32-bit unsigned integers `x` and `y`, producing a 64-bit
/// result.
///
/// The 32 least-significant bits are returned in `lsb`.
///
/// The 32 most-significant bits are returned in `msb`.
public func umulExtended(_ x: UInt32, _ y: UInt32) -> (lsb: UInt32, msb: UInt32) {
    let ex = UInt64(x)
    let ey = UInt64(y)
    let p = ex * ey
    return (UInt32(p & 0xFFFF_FFFF), UInt32(p >> 32))
}

/// Multiplies 32-bit unsigned integers `x` and `y`, producing a 64-bit
/// result.
///
/// The 32 least-significant bits are returned in `lsb`.
///
/// The 32 most-significant bits are returned in `msb`.
public func umulExtended
<
    T: NumberVector
>(_ x: T, _ y: T) -> (lsb: T, msb: T)
    where
    T.Component == UInt32
{
    return map2(x, y, umulExtended)
}

/// Multiplies 32-bit integers `x` and `y`, producing a 64-bit result.
///
/// The 32 least-significant bits are returned in `lsb`.
///
/// The 32 most-significant bits are returned in `msb`.
public func imulExtended(_ x: Int32, _ y: Int32) -> (lsb: Int32, msb: Int32) {
    let ux = unsafeBitCast(x, to: UInt32.self)
    let uy = unsafeBitCast(y, to: UInt32.self)
    let (l, m) = umulExtended(ux, uy)
    let ix = unsafeBitCast(l, to: Int32.self)
    let iy = unsafeBitCast(m, to: Int32.self)
    return (ix, iy)
}

/// Multiplies 32-bit integers `x` and `y`, producing a 64-bit result.
///
/// The 32 least-significant bits are returned in `lsb`.
///
/// The 32 most-significant bits are returned in `msb`.
public func imulExtended
<
    T: NumberVector
>(_ x: T, _ y: T) -> (lsb: T, msb: T)
    where
    T.Component == Int32
{
    return map2(x, y, imulExtended)
}

/// Extracts bits `[offset, offset + bits - 1]` from `value`, returning them in
/// the least significant bits of the result.
///
/// For unsigned data types, the most significant bits of the result will
/// be set to zero. For signed data types, the most significant bits will
/// be set to the value of bit offset + base – 1.
///
/// If `bits` is zero, the result will be zero. The result will be undefined
/// if `offset` or `bits` is negative, or if the sum of `offset` and `bits` is
/// greater than the number of bits used to store the operand.
public func bitfieldExtract
<
    T: BaseInt
>(_ x: T, _ offset: UInt, _ bits: UInt) -> T {
    guard x > T.zero && bits > 0 && offset + bits <= 32 else {
        return T.zero
    }
    let mask = T((1 << bits) - 1)
    return (x >> T(offset)) & mask
}

/// Extracts bits `[offset, offset + bits - 1]` from `value`, returning them in
/// the least significant bits of the result.
///
/// For unsigned data types, the most significant bits of the result will
/// be set to zero. For signed data types, the most significant bits will
/// be set to the value of bit offset + base – 1.
///
/// If `bits` is zero, the result will be zero. The result will be undefined
/// if `offset` or `bits` is negative, or if the sum of `offset` and `bits` is
/// greater than the number of bits used to store the operand.
public func bitfieldExtract<T: IntVector>(_ x: T, _ offset: UInt, _ bits: UInt) -> T {
    return x.map { bitfieldExtract($0, offset, bits) }
}

/// Returns the insertion the `bits` least-significant bits of `insert` into
/// `base`.
///
/// The result will have bits `[offset, offset + bits - 1]` taken from
/// bits `[0, bits – 1]` of `insert`, and all other bits taken directly from
/// the corresponding bits of `base`. If `bits` is zero, the result will
/// simply be `base`.
///
/// The result will be undefined if `offset` or `bits` is negative,
/// or if the sum of `offset` and `bits` is greater than the number of bits
/// used to store the operand.
public func bitfieldInsert
<
    T: BaseInt
>(_ base: T, _ insert: T, _ offset: UInt, _ bits: UInt) -> T {
    guard bits != 0 else { return base }
    let mask = T(((1 << bits) - 1) << offset)
    return (base & ~mask) | (insert & mask)
}

/// Returns the insertion the `bits` least-significant bits of `insert` into
/// `base`.
///
/// The result will have bits `[offset, offset + bits - 1]` taken from
/// bits `[0, bits – 1]` of `insert`, and all other bits taken directly from
/// the corresponding bits of `base`. If `bits` is zero, the result will
/// simply be `base`.
///
/// The result will be undefined if `offset` or `bits` is negative,
/// or if the sum of `offset` and `bits` is greater than the number of bits
/// used to store the operand.
public func bitfieldInsert<T: IntVector>(_ base: T, _ insert: T, _ offset: UInt, _ bits: UInt) -> T {
    return base.zip(insert) { (b, i) in
        return bitfieldInsert(b, i, offset, bits)
    }
}

/// Returns the reversal of the bits of `value`.
///
/// The bit numbered n of the result will be taken from bit `(bits - 1) - n`
/// of `value`, where *bits* is the total number of bits used to represent
/// `value`.
public func bitfieldReverse<T: BaseInt>(_ x: T) -> T {
    func reverse_step32(_ x: UInt32, _ mask: UInt32, _ shift: UInt32) -> UInt32 {
        return ((x & mask) << shift) | ((x & ~mask) >> shift)
    }
    var u = unsafeBitCast(x, to: UInt32.self)
    u = reverse_step32(u, 0x55555555, 1)
    u = reverse_step32(u, 0x33333333, 2)
    u = reverse_step32(u, 0x0F0F0F0F, 4)
    u = reverse_step32(u, 0x00FF00FF, 8)
    u = reverse_step32(u, 0x0000FFFF, 16)
    return unsafeBitCast(u, to: T.self)
}

/// Returns the reversal of the bits of `value`.
///
/// The bit numbered n of the result will be taken from bit `(bits - 1) - n`
/// of `value`, where *bits* is the total number of bits used to represent
/// `value`.
public func bitfieldReverse<T: IntVector>(_ x: T) -> T {
    return x.map(bitfieldReverse)
}

/// Returns the number of bits set to 1 in the binary representation of
/// `value`.
public func bitCount<T: BaseInt>(_ x: T) -> T {
    return T(x.bitCount)
}

/// Returns the number of bits set to 1 in the binary representation of
/// `value`.
public func bitCount<T: IntVector>(_ x: T) -> T {
    return x.map(bitCount)
}

/// Returns the bit number of the least significant bit set to 1 in the binary
/// representation of `value`.
///
/// If `value` is zero, `-1` will be returned.
public func findLSB<T: BaseInt>(_ x: T) -> Int32 {
    guard !x.isZero else { return -1 }
    return Int32(x.trailingZeros)
}

/// Returns the bit number of the least significant bit set to 1 in the binary
/// representation of `value`.
///
/// If `value` is zero, `-1` will be returned.
public func findLSB
<
    T: IntVector,
    I: IntVector
>(_ x: T) -> I
    where
    T.Dim == I.Dim,
    I.Component == Int32
{
    var iv = I.zero
    for i in 0..<T.dimension {
        iv[i] = findLSB(x[i])
    }
    return iv
}

/// Returns the bit number of the most significant bit in the binary
/// representation of `value`.
///
/// For positive integers, the result will be the bit number of the
/// most significant bit set to `1`.
///
/// For negative integers, the result will be the bit number of the most
/// significant bit set to `0`. For a value of zero or negative one, `-1` will
/// be returned.
public func findMSB<T: BaseInt>(_ x: T) -> Int32 {
    guard !x.isZero && x != -1 else { return -1 }
    if x < T.zero {
        return Int32(31 - (~x).leadingZeros)
    } else {
        return Int32(31 - x.leadingZeros)
    }
}

/// Returns the bit number of the most significant bit in the binary
/// representation of `value`.
///
/// For positive integers, the result will be the bit number of the
/// most significant bit set to `1`.
///
/// For negative integers, the result will be the bit number of the most
/// significant bit set to `0`. For a value of zero or negative one, `-1` will
/// be returned.
public func findMSB
<
    T: IntVector,
    I: IntVector
>(_ x: T) -> I
    where
    T.Dim == I.Dim,
    I.Component == Int32
{
    var iv = I.zero
    for i in 0..<T.dimension {
        iv[i] = findMSB(x[i])
    }
    return iv
}
