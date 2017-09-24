//
// GLMath - Common.swift
//
// GLSLangSpec 8.3 Common Functions
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

#if os(Linux)

import Glibc

/// Returns `x`` if `x >= 0`, otherwise it returns `–x`.
public func abs<T: NumericVector>(_ x: T) -> T where T.Component: SignedNumber {
    return x.map(abs)
}

/// Returns `1.0`` if `x > 0`, `0.0` if `x = 0`, or `–1.0`` if `x < 0`.
public func sign<T: BaseFloat>(_ x: T) -> T {
    if x.isZero { return T.zero }
    switch x.sign {
    case .plus: return T.one
    case .minus: return -T.one
    }
}

/// Returns `1.0`` if `x > 0`, `0.0` if `x = 0`, or `–1.0`` if `x < 0`.
public func sign<T: FloatVector>(_ x: T) -> T {
    return x.map(sign)
}

/// Returns a value equal to the nearest integer that is less than or equal to
/// `x`.
public func floor<T: FloatVector>(_ x: T) -> T {
    return x.map(Glibc.floor)
}

/// Returns a value equal to the nearest integer to `x`` whose absolute value
/// is not larger than the absolute value of `x`.
public func trunc<T: FloatVector>(_ x: T) -> T {
    return x.map(Glibc.trunc)
}

/// Returns a value equal to the nearest integer that is greater than or equal
/// to `x`.
public func ceil<T: FloatVector>(_ x: T) -> T {
    return x.map(Glibc.ceil)
}

/// Returns `x – floor (x)`.
public func fract(_ x: Float) -> Float {
    return x.fract
}

/// Returns `x – floor (x)`.
public func fract(_ x: Double) -> Double {
    return x.fract
}

/// Returns `x – floor (x)`.
public func fract<T: FloatVector>(_ x: T) -> T {
    return x.map { $0.fract }
}

/// Returns a value equal to the nearest integer to `x`.
///
/// The fraction `0.5` will round in a direction chosen by the implementation,
/// presumably the direction that is fastest. This includes the possibility
/// that `round(x)` returns the same value as `roundEven(x)` for all values of
/// `x`.
public func round<T: FloatVector>(_ x: T) -> T {
    return x.map(Glibc.round)
}

/// Returns a value equal to the nearest integer to `x`.
///
/// A fractional part of `0.5` will round toward the nearest even integer.
/// (Both `3.5` and `4.5` for x will return `4.0`.)
public func roundEven<T: BaseFloat>(_ x: T) -> T {
    guard abs(x.fract) == 0.5 else { return round(x) }

    let i = trunc(x)
    if Glibc.fmod(i, 2) == 0.0 { return i }
    else if i < 0.0 { return i - 1.0 }
    else { return i + 1.0 }
}

/// Returns the fractional and integer parts of `x`.
///
/// Both parts will have the same sign as `x`.
///
/// - note:
/// In GLSL, the integer part is returned via a output parameter `i`.
/// In _Swift_ we can return both parts using a tuple *(interger part,
/// fractional part)*.
public func modf<T: FloatVector>(_ x: T) -> (i: T, T) where T.Component == Float {
    return x.split { Glibc.modf($0) }
}

/// Returns the fractional and integer parts of `x`.
///
/// Both parts will have the same sign as `x`.
public func modf<T: FloatVector>(_ x: T) -> (i: T, T) where T.Component == Double {
    return x.split { Glibc.modf($0) }
}

#else

import simd
import Darwin

// NOTE: Following functions have been defined in `Darwin` or `simd`
//       for concrete types.
//
// - `abs`,
// - `sign` of float vectors,
// - `floor`,
// - `fract` of vectors,
// - `trunc`,
// - `ceil`,

/// Returns a value equal to the nearest integer to `x`.
///
/// The fraction `0.5` will round in a direction chosen by the implementation,
/// presumably the direction that is fastest. This includes the possibility
/// that `round(x)` returns the same value as `roundEven(x)` for all values of
/// `x`.
public func round<T: FloatVector>(_ x: T) -> T {
    return x.map(Darwin.round)
}

/// Returns a value equal to the nearest integer to `x`.
///
/// A fractional part of `0.5` will round toward the nearest even integer.
/// (Both `3.5` and `4.5` for x will return `4.0`.)
public func roundEven<T: BaseFloat>(_ x: T) -> T {
    guard abs(x.fract) == 0.5 else { return round(x) }

    let i = trunc(x)
    if simd.fmod(i, 2) == 0.0 { return i }
    else if i < 0.0 { return i - 1.0 }
    else { return i + 1.0 }
}

/// Returns the fractional and integer parts of `x`.
///
/// Both parts will have the same sign as `x`.
///
/// - note:
/// In GLSL, the integer part is returned via a output parameter `i`.
/// In _Swift_ we can return both parts using a tuple *(interger part,
/// fractional part)*.
public func modf<T: FloatVector>(_ x: T) -> (i: T, T) where T.Component == Float {
    return x.split(Darwin.modf)
}

/// Returns the fractional and integer parts of `x`.
///
/// Both parts will have the same sign as `x`.
public func modf<T: FloatVector>(_ x: T) -> (i: T, T) where T.Component == Double {
    return x.split(Darwin.modf)
}

#endif

/// Returns `1.0` if `x > 0`, `0.0` if `x = 0`, or `–1.0` if `x < 0`.
public func sign(_ x: Int32) -> Int32 {
    return x.signum
}

/// Returns `1.0` if `x > 0`, `0.0` if `x = 0`, or `–1.0` if `x < 0`.
public func sign<T: IntVector>(_ x: T) -> T where T: GenericSignedNumber {
    return x.signum
}

/// Returns a value equal to the nearest integer to `x`.
///
/// A fractional part of `0.5` will round toward the nearest even integer.
/// (Both `3.5` and `4.5` for x will return `4.0`.)
public func roundEven<T: FloatVector>(_ x: T) -> T {
    return x.map(roundEven)
}

/// Returns x – floor (x).
public func fract<T: GenericFloat>(_ x: T) -> T {
    return x.fract
}

/// Modulus. Returns `x – y ∗ floor(x/y)`.
public func mod<T: BaseFloat>(_ x: T, _ y: T) -> T {
    return x.truncatingRemainder(dividingBy: y)
}

/// Modulus. Returns `x – y ∗ floor(x/y)`.
public func mod<T: FloatVector>(_ x: T, _ y: T) -> T {
    return x.zip(y, mod)
}

/// Modulus with a scalar number.
public func mod<T: FloatVector>(_ x: T, _ y: T.Component) -> T {
    return x.map { mod($0, y) }
}

/// Returns `y` if `y < x`, otherwise it returns `x`.
public func min<T: NumericVector>(_ x: T, _ y: T.Component) -> T {
    return x.map { min($0, y) }
}

/// Returns `y` if `y < x`, otherwise it returns `x`.
public func min<T: NumericVector>(_ x: T, _ y: T) -> T {
    return x.zip(y, min)
}

/// Returns `y` if `x < y`, otherwise it returns `x`.
public func max<T: NumericVector>(_ x: T, _ y: T.Component) -> T {
    return x.map { max($0, y) }
}

/// Returns `y` if `x < y`, otherwise it returns `x`.
public func max<T: NumericVector>(_ x: T, _ y: T) -> T {
    return x.zip(y, max)
}

/// Returns `min (max (x, minVal), maxVal)`.
public func clamp<T: BaseNumber>(_ x: T, _ minVal: T, _ maxVal: T) -> T {
    return min(max(x, minVal), maxVal)
}

/// Returns `min (max (x, minVal), maxVal)`.
public func clamp<T: NumericVector>(_ x: T, _ minVal: T, _ maxVal: T) -> T {
    // TODO: Use `gyb` to generate functions that call `simd::clamp(:min:max)`.
    return x.zip(minVal, max).zip(maxVal, min)
}

/// Returns `min (max (x, minVal), maxVal)`.
public func clamp<T: NumericVector>(_ x: T, _ minVal: T.Component, _ maxVal: T.Component) -> T {
    return x.map { min(max($0, minVal), maxVal) }
}

/// Returns the linear blend of `x` and `y`, i.e., `x⋅(1−a)+y⋅a`.
public func mix<T: BaseFloat>(_ x: T, _ y: T, _ a: T) -> T {
    return x.interpolate(y, t: a)
}

/// Returns the linear blend of `x` and `y`, i.e., `x⋅(1−a)+y⋅a`.
public func mix<T: FloatVector>(_ x: T, _ y: T, _ a: T) -> T {
    return x.mix(y, t: a)
}

/// Returns the linear blend of `x` and `y`, i.e., `x⋅(1−a)+y⋅a`.
public func mix<T: FloatVector>(_ x: T, _ y: T, _ a: T.Component) -> T {
    return x.mix(y, t: T(a))
}

/// Selects which vector each returned component comes from.
///
/// For a component of `a` that is `false`, the corresponding component of `x`
/// is returned. For a component of `a` that is `true`, the corresponding
/// component of `y` is returned. Components of `x` and `y` that are not
/// selected are allowed to be invalid floating point values and will have no
/// effect on the results.
public func mix<T: BaseFloat>(_ x: T, _ y: T, _ a: Bool) -> T {
    if a { return y }
    else { return x }
}

/// Selects which vector each returned component comes from.
///
/// For a component of `a` that is `false`, the corresponding component of `x`
/// is returned. For a component of `a` that is `true`, the corresponding
/// component of `y` is returned. Components of `x` and `y` that are not
/// selected are allowed to be invalid floating point values and will have no
/// effect on the results.
public func mix
<
    T: FloatVector,
    B: Vector
>(_ x: T, _ y: T, _ a: B) -> T
    where
    B.Dim == T.Dim,
    B.Component == Bool
{
    var r = T.zero
    for i in 0 ..< T.dimension {
        if a[i] { r[i] = y[i] }
        else { r[i] = x[i] }
    }
    return r
}

/// Returns `0.0`` if `x < edge`; otherwise it returns `1.0`.
public func step<T: BaseFloat>(_ edge: T, _ x: T) -> T {
    return x.step(edge)
}

/// Returns `0.0`` if `x < edge`; otherwise it returns `1.0`.
public func step<T: FloatVector>(_ edge: T, _ x: T) -> T {
    return x.step(edge)
}

/// Returns `0.0`` if `x < edge`; otherwise it returns `1.0`.
public func step<T: FloatVector>(_ edge: T.Component, _ x: T) -> T {
    return step(T(edge), x)
}

/// Returns `0.0` if `x <= edge0` and `1.0` if `x >= edge1` and performs smooth
/// Hermite interpolation between `0` and `1` when `edge0 < x < edge1`.
///
/// This is useful in cases where you would want a threshold function
/// with a smooth transition.
///
/// This is equivalent to:
/// ```
/// genType t;
/// t = clamp ((x – edge0) / (edge1 – edge0), 0, 1);
/// return t * t * (3 – 2 * t);
/// ```
/// - note: Results are undefined if `edge0 >= edge1`.
public func smoothstep<T: BaseFloat>(_ edge0: T, _ edge1: T, _ x: T) -> T {
    precondition(edge1 > edge0)
    let t = clamp((x - edge0) / (edge1 - edge0), 0, 1)
    return t * t * (3 - 2 * t)
}

/// Returns `0.0` if `x <= edge0` and `1.0` if `x >= edge1` and performs smooth
/// Hermite interpolation between `0` and `1` when `edge0 < x < edge1`.
public func smoothstep<T: FloatVector>(_ edge0: T, _ edge1: T, _ x: T) -> T {
    return x.smoothstep(edge0, edge1)
}

/// Returns `0.0` if `x <= edge0` and `1.0` if `x >= edge1` and performs smooth
/// Hermite interpolation between `0` and `1` when `edge0 < x < edge1`.
public func smoothstep<T: FloatVector>(_ edge0: T.Component, _ edge1: T.Component, _ x: T) -> T {
    return smoothstep(T(edge0), T(edge1), x)
}

func mapVec
<
    T: Vector,
    R: Vector
>(_ x: T, _ op: (T.Component) -> R.Component) -> R
    where
    T.Dim == R.Dim
{
    var v: [R.Component] = []
    for i in 0 ..< T.dimension {
        v.append(op(x[i]))
    }
    return R(v)
}

/// Returns `true` if `x` holds a *NaN*. Returns `false` otherwise.
public func isnan<T: BaseFloat>(_ x: T) -> Bool {
    return x.isNaN
}

/// Returns `true` if `x` holds a *NaN*. Returns `false` otherwise.
public func isnan
<
    T: FloatVector,
    B: Vector
>(_ x: T) -> B
    where
    T.Dim == B.Dim,
    B.Component == Bool
{
    return mapVec(x) { $0.isNaN }
}

/// Returns `true` if `x` holds a positive infinity or negative infinity.
/// Returns `false` otherwise.
public func isinf<T: BaseFloat>(_ x: T) -> Bool {
    return x.isInfinite
}

/// Returns `true` if `x` holds a positive infinity or negative infinity.
/// Returns `false` otherwise.
public func isinf
<
    T: FloatVector,
    B: Vector
>(_ x: T) -> B
    where
    T.Dim == B.Dim,
    B.Component == Bool
{
    return mapVec(x) { $0.isInfinite }
}

/// Returns a signed integer value representing the encoding of
/// a floating-point value.
///
/// The floating-point value's bit-level representation is preserved.
public func floatBitsToInt(_ x: Float) -> Int32 {
    return Int32(bitPattern: x.bitPattern)
}

/// Returns a signed integer value representing the encoding of
/// a floating-point value.
///
/// The floating-point value's bit-level representation is preserved.
public func floatBitsToInt<G: Vector, T: FloatVector>(_ value: T) -> G
    where
    G.Component == Int32,
    T.Component == Float,
    G.Dim == T.Dim
{
    return mapVec(value, floatBitsToInt)
}

/// Returns a unsigned integer value representing the encoding of
/// a floating-point value.
///
/// The floating- point value's bit-level representation is preserved.
public func floatBitsToUint(_ x: Float) -> UInt32 {
    return x.bitPattern
}

/// Returns a unsigned integer value representing the encoding of
/// a floating-point value.
///
/// The floating- point value's bit-level representation is preserved.
public func floatBitsToUint
<
    G: Vector,
    T: FloatVector
>(_ value: T) -> G
    where
    G.Component == UInt32,
    T.Component == Float,
    G.Dim == T.Dim
{
    return mapVec(value, floatBitsToUint)
}

/// Returns a floating-point value corresponding to a signed integer encoding
/// of a floating-point value.
public func intBitsToFloat(_ x: Int32) -> Float {
    return Float(bitPattern: UInt32(bitPattern: x))
}

/// Returns a floating-point value corresponding to a signed integer encoding
/// of a floating-point value.
public func intBitsToFloat
<
    T: Vector,
    G: FloatVector
>(_ value: T) -> G
    where
    T.Component == Int32,
    G.Component == Float,
    T.Dim == G.Dim
{
    return mapVec(value, intBitsToFloat)
}

/// Returns a floating-point value corresponding to a unsigned integer encoding
/// of a floating-point value.
public func uintBitsToFloat(_ x: UInt32) -> Float {
    return Float(bitPattern: x)
}

/// Returns a floating-point value corresponding to a unsigned integer encoding
/// of a floating-point value.
public func uintBitsToFloat
<
    T: Vector,
    G: FloatVector
>(_ value: T) -> G
    where
    T.Component == UInt32,
    G.Component == Float,
    T.Dim == G.Dim
{
    return mapVec(value, uintBitsToFloat)
}

/// Computes and returns `a * b + c`.
public func fma<T: FloatVector>(_ a: T, _ b: T, _ c: T) -> T {
    return a * b + c
}

/// Splits `x` into a floating-point significand in the range [0.5, 1.0) and
/// an integral exponent of two, such that:
/// *x = significand⋅2<sup>exponent</sup>*.
///
/// For a floating-point value of zero, the significant and exponent are both
/// zero.
///
/// For a floating-point value that is an infinity or is not a number,
/// the results are undefined.
///
/// - Note:
///
/// In GLSL, the significand is returned by the function and the exponent is
/// returned in the output parameter `exp`. In Rust, we have the luxury to
/// return both of them very naturally via a tuple.
public func frexp
<
    T: FloatVector,
    S: IntVector
>(_ x: T) -> (T, exp: S)
    where
    T.Dim == S.Dim,
    S.Component == Int32
{
    var a = T.zero
    var b = S.zero
    for i in 0 ..< T.dimension {
        let (f, exp) = x[i].frexp
        a[i] = f
        b[i] = Int32(exp)
    }
    return (a, b)
}

/// Builds a floating-point number from `x` and the corresponding integral
/// exponent of two in `exp`, returning:
/// *significand ⋅ 2<sup>exponent</sup>*.
///
/// If this product is too large to be represented in the floating-point type,
/// the result is undefined.
public func ldexp
<
    T: FloatVector,
    I: IntVector
>(_ x: T, _ exp: I) -> T
    where
    T.Dim == I.Dim,
    I.Component == Int32
{
    var a = T.zero
    for i in 0 ..< T.dimension {
        a[i] = x[i].ldexp(Int(exp[i]))
    }
    return a
}
