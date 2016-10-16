//
// GLMath - Geom.swift
//
// GLSLangSpec 8.5 Geometric Functions
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import Darwin

// NOTE: `cross`, `refelct` and `refract` have been defined in `simd`.

/// Returns the length of vector `x`.
public func length<T: FloatVector>(_ x: T) -> T.Component {
    return x.length
}

/// Returns the distance between `p0` and `p1`.
public func distance<T: FloatVector>(_ p0: T, _ p1: T) -> T.Component {
    return p0.distance(to: p1)
}

/// Returns the dot product of `x` and `y`.
public func dot<T: FloatVector>(_ x: T, _ y: T) -> T.Component {
    return x.dot(y)
}

/// Returns a vector in the same direction as `x` but with a length of `1`.
public func normalize<T: FloatVector>(_ x: T) -> T {
    return x.normalize
}

/// If `dot(Nref, I) < 0` return *N*, otherwise return *-N*.
public func faceforward<T: FloatVector>(_ n: T, _ i: T, _ nref: T) -> T {
    if nref.dot(i) < 0 {
        return n
    } else {
        return -n
    }
}
