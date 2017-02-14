//
// GLMath - Matrix.swift
//
// Matrix types.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

/// Generic matrix type.
///
/// A matrix is treated as vector of vectors of float number.
public protocol GenericMatrix: Vector, ApproxEquatable {

    associatedtype Component: FloatVector
    associatedtype NumberType = Component.NumberType

    // SWIFT EVOLUTION: This can't compiled on Linux (circa 3.0.2).
    // subscript (column: Int, row: Int) -> Component.Component { get }

    // NOTE: Property `transpose` can't be defined here, because the result
    //       type can't be expressed on a generic way.
}

/// Generic type of square matrices.
public protocol GenericSquareMatrix: GenericMatrix, One, Zero {

    associatedtype Dim = Component.Dim

    static var identity: Self { get }

    /// Returns the inverse of the receiver.
    var inverse: Self { get }

    /// Returns the determinant of a square matrix.
    var determinant: Component.Component { get }

    var transpose: Self { get }

    init (diagonal: Component)
}

public extension GenericMatrix {

    var x: Component {
        get { return self[0] }
        set { self[0] = newValue }
    }

    var y: Component {
        get { return self[1] }
        set { self[1] = newValue }
    }
}

extension GenericMatrix where NumberType == Component.NumberType {

    // NOTE: Constraint `NumberType == Component.NumberType` is redundant,
    //       but SWIFT (3.0.2) can't handle type relationships with indirection.

    public func isClose(to: Self, tolerance: Self.NumberType) -> Bool {
        for i in 0 ..< Self.dimension {
            guard self[i].isClose(to: to[i], tolerance: tolerance) else {
                return false
            }
        }
        return true
    }
}

public extension GenericMatrix where Self: Vector3 {

    var z: Component {
        get { return self[2] }
        set { self[2] = newValue }
    }
}

public extension GenericMatrix where Self: Vector4 {

    var z: Component {
        get { return self[2] }
        set { self[2] = newValue }
    }

    var w: Component {
        get { return self[3] }
        set { self[3] = newValue }
    }
}

// MARK: GenericSquareMatrix

public extension GenericSquareMatrix {

    static var identity: Self {
        return self.init(diagonal: Component.one)
    }

    static var one: Self { return identity }

    static var zero: Self {
        return self.init(diagonal: Component.zero)
    }
}

public extension GenericSquareMatrix where Self: Vector2, Self.Component: FloatVector2 {

    var determinant: Component.Component {
        return x.x * y.y - x.y * y.x
    }
}

public extension GenericSquareMatrix where Self: Vector3, Self.Component: FloatVector3 {

    var determinant: Component.Component {
        let a = x.x * (y.y * z.z - z.y * y.z)
        let b = y.x * (x.y * z.z - z.y * x.z)
        let c = z.x * (x.y * y.z - y.y * x.z)
        return a - b + c
    }
}
