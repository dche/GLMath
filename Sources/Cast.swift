//
// GLMath - Cast.swift
//
// Explicit type casting.
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

extension NumericVector {

    /// Constructs a numreic vector from a boolean vector with same dimension.
    ///
    /// - parameter b: A boolean vector.
    ///
    /// ## Example
    /// ```
    /// import GLMath
    ///
    /// let b3 = bvec3(true, true, false)
    /// let i3 = ivec3(b3)
    /// assert(i3.x == 1 && i3.y == 1 && i3.z == 0)
    /// ```
    public init<T: Vector>(_ b: T)
        where
        T.Dim == Self.Dim,
        T.Component == Bool
    {
        var a = Self(Self.Component.zero)
        for i in 0 ..< T.dimension {
            if b[i] { a[i] = Self.Component.one }
        }
        self = a
    }
}

extension Vector where Component == Bool {

    /// Constructs a boolean vector from a numeric vector with same dimension.
    ///
    /// - parameter v: A numeric vector.
    public init<T: NumericVector>(_ v: T) where T.Dim == Self.Dim {
        var a = Self(true)
        for i in 0 ..< T.dimension {
            if v[i].isZero { a[i] = false }
        }
        self = a
    }
}
