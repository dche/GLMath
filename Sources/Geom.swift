//
// GLMath - Geom.swift
//
// GLSLangSpec 8.5 Geometric Functions
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import Darwin

// NOTE: Following functions have been defined in `simd`.
//
// - `dot`,
// - `length',
// - `normalize`,
// - `distance`,
// - `reflect`,
// - `refract`,
// - `cross`.

/// If `dot(Nref, I) < 0` return *N*, otherwise return *-N*.
public func faceforward<T: FloatVector>(_ n: T, _ i: T, _ nref: T) -> T {
    if nref.dot(i) < 0 {
        return n
    } else {
        return -n
    }
}
