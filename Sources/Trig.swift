//
// GLMath - Trig.swift
//
// GLSLangSpec 8.1 Angle and Trigonometry Functions
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import Darwin

public func radians(_ degrees: Float) -> Float {
    return degrees * Float.pi * 0.0055555555555555558
}

public func radians(_ degrees: Double) -> Double {
    return degrees * Double.pi * 0.0055555555555555558
}

/// Converts `degrees` to radians, i.e., `π/180 * degrees`.
public func radians<T: FloatVector>(_ degrees: T) -> T {
    return degrees * T.pi * 0.0055555555555555558
}

/// Converts `radians` to degrees, i.e., `180/π * radians`.
public func degrees(_ radians: Float) -> Float {
    return radians * Float.one_over_pi * 180
}

/// Converts `radians` to degrees, i.e., `180/π * radians`.
public func degrees(_ radians: Double) -> Double {
    return radians * Double.one_over_pi * 180
}

/// Converts `radians` to degrees, i.e., `180/π * radians`.
public func degrees<T: FloatVector>(_ radians: T) -> T {
    return radians * T.one_over_pi * 180
}

/// The standard trigonometric sine function.
public func sin<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.sin)
}

/// The standard trigonometric sine function.
public func sin<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.sin)
}

/// The standard trigonometric cosine function.
public func cos<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.cos)
}

/// The standard trigonometric cosine function.
public func cos<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.cos)
}

/// The standard trigonometric tangent.
public func tan<T: FloatVector>(_ angle: T) -> T where T.Component == Float {
    return angle.map(Darwin.tan)
}

/// The standard trigonometric tangent.
public func tan<T: FloatVector>(_ angle: T) -> T where T.Component == Double {
    return angle.map(Darwin.tan)
}

/// Returns an angle whose sine is `x`.
///
/// The range of values returned by this function is `[-π/2, π/2]`.
///
/// Results are undefined if `|x| > 1`.
public func asin<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.asin)
}

/// Returns an angle whose sine is `x`.
///
/// The range of values returned by this function is `[-π/2, π/2]`.
///
/// Results are undefined if `|x| > 1`.
public func asin<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.asin)
}

/// Returns an angle whose cosine is `x`.
///
/// The range of values returned by this function is `[0, π]`.
///
/// Results are undefined if `∣x∣ > 1`.
public func acos<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.acos)
}

/// Returns an angle whose cosine is `x`.
///
/// The range of values returned by this function is `[0, π]`.
///
/// Results are undefined if `∣x∣ > 1`.
public func acos<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.acos)
}

/// Returns an angle whose tangent is `y / x`.
///
/// The signs of `x` and `y` are used to determine what quadrant the angle is
/// in.
///
/// The range of values returned by this function is `[−π, π]`.
///
/// Results are undefined if `x` and `y` are both `0`.
public func atan<T: FloatVector>(_ y: T, _ x: T) -> T where T.Component == Float {
    return x.zip(y, Darwin.atan2)
}

/// Returns an angle whose tangent is `y / x`.
///
/// The signs of `x` and `y` are used to determine what quadrant the angle is
/// in.
///
/// The range of values returned by this function is `[−π, π]`.
///
/// Results are undefined if `x` and `y` are both `0`.
public func atan<T: FloatVector>(_ y: T, _ x: T) -> T where T.Component == Double {
    return x.zip(y, Darwin.atan2)
}

/// Returns an angle whose tangent is `y_over_x`.
///
/// The range of values returned by this function is `[-π/2, π/2]`.
public func atan<T: FloatVector>(_ y_over_x: T) -> T where T.Component == Float {
    return y_over_x.map(Darwin.atan)
}

/// Returns an angle whose tangent is `y_over_x`.
///
/// The range of values returned by this function is `[-π/2, π/2]`.
public func atan<T: FloatVector>(_ y_over_x: T) -> T where T.Component == Double {
    return y_over_x.map(Darwin.atan)
}

/// Returns the hyperbolic sine function (e<sup>x</sup> - e<sup>-x</sup>) / 2.
public func sinh<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.sinh)
}

/// Returns the hyperbolic sine function (e<sup>x</sup> - e<sup>-x</sup>) / 2.
public func sinh<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.sinh)
}

/// Returns the hyperbolic cosine function (e<sup>x</sup> + e<sup>-x</sup>) / 2.
public func cosh<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.cosh)
}

/// Returns the hyperbolic cosine function (e<sup>x</sup> + e<sup>-x</sup>) / 2.
public func cosh<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.cosh)
}

/// Returns the hyperbolic tangent function `sinh(x)/cosh(x)`.
public func tanh<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.tanh)
}

/// Returns the hyperbolic tangent function `sinh(x)/cosh(x)`.
public func tanh<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.tanh)
}

/// Arc hyperbolic sine; returns the inverse of **sinh**.
public func asinh<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.asinh)
}

/// Arc hyperbolic sine; returns the inverse of **sinh**.
public func asinh<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.asinh)
}

/// Arc hyperbolic cosine; returns the non-negative inverse of **cosh**.
///
/// Results are undefined if `x < 1`.
public func acosh<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.acosh)
}

/// Arc hyperbolic cosine; returns the non-negative inverse of **cosh**.
///
/// Results are undefined if `x < 1`.
public func acosh<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.acosh)
}

/// Arc hyperbolic tangent; returns the inverse of **tanh**.
///
/// Results are undefined if `∣x∣ ≥ 1`.
public func atanh<T: FloatVector>(_ x: T) -> T where T.Component == Float {
    return x.map(Darwin.atanh)
}

/// Arc hyperbolic tangent; returns the inverse of **tanh**.
///
/// Results are undefined if `∣x∣ ≥ 1`.
public func atanh<T: FloatVector>(_ x: T) -> T where T.Component == Double {
    return x.map(Darwin.atanh)
}
