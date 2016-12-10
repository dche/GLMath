//
// GLMath - GeomExt.swift
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

extension FloatVector {

    /// The squre of the length of vector `x`.
    public var squareLength: Component {
        return self.dot(self)
    }

    /// Normalizes vector `self` to specific length `len`.
    public func normalize(to len: Component) -> Self {
        return self.normalize * len
    }

    /// Projects `self` on vector `y`.
    public func projection(on y: Self) -> Self {
        let sl = y.squareLength
        if sl.isClose(to: Component.zero, tolerance: sl * Component.epsilon) {
            return Self.zero
        }
        return y * self.dot(y) * sl.recip
    }

    /// Returns `true` if `self` is perpendicular to `y`, i.e.,
    /// angle between `self` and `y` is π/2.
    public func isPerpendicular(to y: Self) -> Bool {
        let d = self.dot(y)
        return d.isClose(to: Component.zero, tolerance: Component.epsilon * d)
    }

    /// Returns angle between `self` and `y`.
    ///
    /// The return value is in radian unit and in the interval [0, π].
    public func angle(between y: Self) -> Component {
        let sm = self.squareLength * y.squareLength
        if sm.isClose(to: Component.zero, tolerance: sm * Component.epsilon) {
            return Component.zero
        }
        return (self.dot(y) * inversesqrt(sm)).acos
    }

    /// Returns the absolute value of `self.dot(y)`.
    public func absDot(_ y: Self) -> Component {
        return abs(self.dot(y))
    }
}
