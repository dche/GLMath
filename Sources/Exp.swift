//
// GLMath - Exp.swift
//
// GLSLangSpec 8.2 Exponential Functions
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

#if os(Linux)

import Glibc

/// Returns `x` raised to the `y` power, i.e., *x<sup>y</sup>*.
///
/// Results are undefined if `x < 0`.
///
/// Results are undefined if `x = 0` and `y ≤ 0`.
public func pow<T: FloatVector>(_ x: T, _ y: T) -> T where T.Component == Float {
    return x.zip(y, Glibc.pow)
}

/// Returns `x` raised to the `y` power, i.e., *x<sup>y</sup>*.
///
/// Results are undefined if `x < 0`.
///
/// Results are undefined if `x = 0` and `y ≤ 0`.
public func pow<T: FloatVector>(_ x: T, _ y: T) -> T where T.Component == Double {
    return x.zip(y, Glibc.pow)
}

/// Returns the natural exponentiation of `x`. i.e., *e<sup>x</sup>*.
public func exp<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Glibc.exp)
}

/// Returns the natural exponentiation of `x`. i.e., *e<sup>x</sup>*.
public func exp<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Glibc.exp)
}

/// Returns the natural logarithm of `x`. i.e., the value `y` which satisfies
/// *x = e<sup>y</sup>*.
public func log<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Glibc.log)
}

/// Returns the natural logarithm of `x`. i.e., the value `y` which satisfies
/// *x = e<sup>y</sup>*.
public func log<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Glibc.log)
}

/// Returns `2` raised to the power of `x`. i.e., *2<sup>x</sup>*.
public func exp2<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Glibc.exp2)
}

/// Returns `2` raised to the power of `x`. i.e., *2<sup>x</sup>*.
public func exp2<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Glibc.exp2)
}

/// Returns the base `2` logarithm of `x`. i.e., the value `y` which satisfies
/// *x = 2<sup>y</sup>*.
public func log2<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Glibc.log2)
}

/// Returns the base `2` logarithm of `x`. i.e., the value `y` which satisfies
/// *x = 2<sup>y</sup>*.
public func log2<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Glibc.log2)
}

/// Returns the square root of `x`. i.e., the value `sqrt(x)`.
///
/// Results are undefined if `x < 0`.
public func sqrt<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Glibc.sqrt)
}

/// Returns the square root of `x`. i.e., the value `sqrt(x)`.
///
/// Results are undefined if `x < 0`.
public func sqrt<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Glibc.sqrt)
}

#else

import Darwin

/// Returns `x` raised to the `y` power, i.e., *x<sup>y</sup>*.
///
/// Results are undefined if `x < 0`.
///
/// Results are undefined if `x = 0` and `y ≤ 0`.
public func pow<T: FloatVector>(_ x: T, _ y: T) -> T where T.Component == Float {
    return x.zip(y, Darwin.pow)
}

/// Returns `x` raised to the `y` power, i.e., *x<sup>y</sup>*.
///
/// Results are undefined if `x < 0`.
///
/// Results are undefined if `x = 0` and `y ≤ 0`.
public func pow<T: FloatVector>(_ x: T, _ y: T) -> T where T.Component == Double {
    return x.zip(y, Darwin.pow)
}

/// Returns the natural exponentiation of `x`. i.e., *e<sup>x</sup>*.
public func exp<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.exp)
}

/// Returns the natural exponentiation of `x`. i.e., *e<sup>x</sup>*.
public func exp<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.exp)
}

/// Returns the natural logarithm of `x`. i.e., the value `y` which satisfies
/// *x = e<sup>y</sup>*.
public func log<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.log)
}

/// Returns the natural logarithm of `x`. i.e., the value `y` which satisfies
/// *x = e<sup>y</sup>*.
public func log<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.log)
}

/// Returns `2` raised to the power of `x`. i.e., *2<sup>x</sup>*.
public func exp2<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.exp2)
}

/// Returns `2` raised to the power of `x`. i.e., *2<sup>x</sup>*.
public func exp2<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.exp2)
}

/// Returns the base `2` logarithm of `x`. i.e., the value `y` which satisfies
/// *x = 2<sup>y</sup>*.
public func log2<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.log2)
}

/// Returns the base `2` logarithm of `x`. i.e., the value `y` which satisfies
/// *x = 2<sup>y</sup>*.
public func log2<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.log2)
}

/// Returns the square root of `x`. i.e., the value `sqrt(x)`.
///
/// Results are undefined if `x < 0`.
public func sqrt<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.sqrt)
}

/// Returns the square root of `x`. i.e., the value `sqrt(x)`.
///
/// Results are undefined if `x < 0`.
public func sqrt<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.sqrt)
}

#endif

/// Returns the inverse of the square root of `x`. i.e., the value `1/sqrt(x)`.
///
/// Results are undefined if `x ≤ 0`.
public func inversesqrt<T: GenericFloat>(_ x: T) -> T {
    return x.rsqrt
}
