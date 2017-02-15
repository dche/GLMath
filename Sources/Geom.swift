//
// GLMath - Geom.swift
//
// GLSLangSpec 8.5 Geometric Functions
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

// NOTE: For Apple platforms, `cross`, `refelct` and `refract` have been
//       defined in `simd`.

#if os(Linux)

/// Returns the cross product of `x`` and `y`.
public func cross<T: FloatVector3>(_ x: T, _ y: T) -> T {
    return x.cross(y)
}

/// For the incident vector *I* and surface orientation *N*,
/// returns the reflection direction:
/// ```
/// I – 2 ∗ dot(N, I) ∗ N
/// ```
///
/// *N* must already be normalized in order to achieve the desired result.
public func reflect<T: FloatVector>(_ i: T, _ n: T) -> T {
    let d = i.dot(n)
    return i - n * (d + d)
}

/// For the incident vector *I* and surface normal *N*, and the ratio of
/// indices of refraction `eta`, return the refraction vector.
///
/// The result is computed by,
/// ```
/// k = 1.0 - eta * eta * (1.0 - dot(N, I) * dot(N, I))
/// if (k < 0.0)
///     return genType(0.0) // or genDType(0.0)
/// else
///     return eta * I - (eta * dot(N, I) + sqrt(k)) * N
/// ```
///
/// The input parameters for the incident vector *I* and the surface normal *N*
/// must already be normalized to get the desired results.
public func refract<T: FloatVector>(_ i: T, _ n: T, _ eta: T.Component) -> T {
    let d = i.dot(n)
    let k = T.Component.one - eta * eta * (T.Component.one - d) * d
    if k < T.Component.zero { return T.zero }
    return i * eta - n * (eta * d + k.sqrt)
}

#endif

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
