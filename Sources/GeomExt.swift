//
// GLMath - GeomExt.swift
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

extension FloatVector {

    /// The square of the length of the receiver.
    public var lengthSquared: Component {
        return self.dot(self)
    }

    /// The square of the distance from the receiver to another vector `y`.
    public func distanceSquared(to y: Self) -> Component {
        return (y - self).lengthSquared
    }

    /// Normalizes vector `self` to specific length `len`.
    public func normalize(to len: Component) -> Self {
        return self.normalize * len
    }

    /// Projects `self` on vector `y`.
    public func projection(on y: Self) -> Self {
        let ls = y.lengthSquared
        if ls.isClose(to: Component.zero, tolerance: ls * Component.epsilon) {
            return Self.zero
        }
        return y * self.dot(y) * ls.recip
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
        let sm = self.lengthSquared * y.lengthSquared
        if sm.isClose(to: Component.zero, tolerance: sm * Component.epsilon) {
            return Component.zero
        }
        let cos = self.dot(y) * inversesqrt(sm)
        if abs(cos).isClose(to: Component.one, tolerance: sm * Component.epsilon) {
            if cos > 0 { return Component.zero }
            return Component.pi
        }
        // FIXME: The precision is poor. Should use better algorithm.
        return cos.acos
    }
}
