//
// GLMath - VecRel.swift
//
// GLSLangSpec 8.7 Vector Relational Functions
//
// Copyright (c) 2016 The GLMath authors
// Licensed under MIT License

func vecRel<T: NumericVector>(
    _ x: T,
    _ y: T,
    _ p: (T.Component, T.Component) -> Bool
) -> T.AssociatedBooleanVector {
    var a = T.AssociatedBooleanVector(false)
    for i in 0 ..< T.dimension {
        a[i] = p(x[i], y[i])
    }
    return a
}

/// Returns the component-wise compare of `x < y`.
public func lessThan<T: NumericVector>(
    _ x: T,
    _ y: T
) -> T.AssociatedBooleanVector {
    return vecRel(x, y, <)
}

/// Returns the component-wise compare of `x ≤ y`.
public func lessThanEqual<T: NumericVector>(
    _ x: T,
    _ y: T
) -> T.AssociatedBooleanVector {
    return vecRel(x, y, <=)
}

/// Returns the component-wise compare of `x > y`.
public func greaterThan<T: NumericVector>(
    _ x: T,
    _ y: T
) -> T.AssociatedBooleanVector {
    return vecRel(x, y, >)
}

/// Returns the component-wise compare of `x ≥ y`.
public func greaterThanEqual<T: NumericVector>(
    _ x: T,
    _ y: T
) -> T.AssociatedBooleanVector {
    return vecRel(x, y, >=)
}

/// Returns the component-wise compare of `x == y`.
public func equal<T: NumericVector>(
    _ x: T,
    _ y: T
) -> T.AssociatedBooleanVector {
    return vecRel(x, y, ==)
}

/// Returns the component-wise compare of `x ≠ y`.
public func notEqual<T: NumericVector>(
    _ x: T,
    _ y: T
) -> T.AssociatedBooleanVector {
    return vecRel(x, y, !=)
}

/// Returns `true` if any component of `x` is **true**.
public func any<T: Vector>(_ x: T) -> Bool
    where
    T.Component == Bool
{
    return x.reduce { $0 || $1 }
}

/// Returns `true` only if all components of `x` are **true**.
public func all<T: Vector>(_ x: T) -> Bool
    where
    T.Component == Bool
{
    return x.reduce { $0 && $1 }
}

/// Returns the component-wise logical complement of `x`.
public func not<T: Vector>(_ x: T) -> T
    where
    T.Component == Bool
{
    return x.map { !$0 }
}
