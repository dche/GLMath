//
// GLMath - Cast.swift
//
// Explicit type casting.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

extension NumberVector {

    /// Constructs a number vector from a boolean vector with same dimension.
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
    public init<T: Vector>(_ b: T) where T.Dim == Self.Dim, T.Component == Bool {
        var a = Self(Self.Component.zero)
        for i in 0 ..< T.dimension {
            if b[i] { a[i] = Self.Component.one }
        }
        self = a
    }
}

// TODO: NumberVector -> BoolVector
