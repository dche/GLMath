//
// GLMath - VecRel.swift
//
// GLSLangSpec 8.7 Vector Relational Functions
//
// Copyright (c) 2016 The GLMath authors
// Licensed under MIT License

func vecRel
<
    V: Vector,
    B: Vector
>(_ x: V, _ y: V, _ p: (V.Component, V.Component) -> Bool) -> B
    where
    B.Component == Bool,
    B.Dim == V.Dim
{
    var a = B(false)
    for i in 0 ..< V.dimension {
        a[i] = p(x[i], y[i])
    }
    return a
}

/// Returns the component-wise compare of `x < y`.
public func lessThan
<
    V: Vector,
    B: Vector
>(_ x: V, _ y: V) -> B
    where
    V.Component: Comparable,
    B.Component == Bool,
    B.Dim == V.Dim
{
    return vecRel(x, y, <)
}

/// Returns the component-wise compare of `x ≤ y`.
public func lessThanEqual
<
    V: Vector,
    B: Vector
>(_ x: V, _ y: V) -> B
    where
    V.Component: Comparable,
    B.Component == Bool,
    B.Dim == V.Dim
{
    return vecRel(x, y, <=)
}

/// Returns the component-wise compare of `x > y`.
public func greaterThan
<
    V: Vector,
    B: Vector
>(_ x: V, _ y: V) -> B
    where
    V.Component: Comparable,
    B.Component == Bool,
    B.Dim == V.Dim
{
    return vecRel(x, y, >)
}

/// Returns the component-wise compare of `x ≥ y`.
public func greaterThanEqual
<
    V: Vector,
    B: Vector
>(_ x: V, _ y: V) -> B
    where
    V.Component: Comparable,
    B.Component == Bool,
    B.Dim == V.Dim
{
    return vecRel(x, y, >=)
}

/// Returns the component-wise compare of `x == y`.
public func equal
<
    V: Vector,
    B: Vector
>(_ x: V, _ y: V) -> B
    where
    V.Component: Comparable,
    B.Component == Bool,
    B.Dim == V.Dim
{
    return vecRel(x, y, ==)
}

/// Returns the component-wise compare of `x ≠ y`.
public func notEqual
<
    V: Vector,
    B: Vector
>(_ x: V, _ y: V) -> B
    where
    V.Component: Comparable,
    B.Component == Bool,
    B.Dim == V.Dim
{
    return vecRel(x, y, !=)
}

/// Returns `true` if any component of `x` is **true**.
public func any<T: Vector>(_ x: T) -> Bool where T.Component == Bool {
    return x.reduce { $0 || $1 }
}

/// Returns `true` only if all components of `x` are **true**.
public func all<T: Vector>(_ x: T) -> Bool where T.Component == Bool {
    return x.reduce { $0 && $1 }
}

/// Returns the component-wise logical complement of `x`.
public func not<T: Vector>(_ x: T) -> T where T.Component == Bool {
    return x.map { !$0 }
}
