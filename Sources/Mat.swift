//
// GLMath - Mat.swift
//
// GLSLangSpec 8.6 Matrix Functions
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

/// Multiply matrix `x` by matrix `y` component-wise, i.e., `result[i][j]` is
/// the scalar product of `x[i][j]` and `y[i][j]`.
///
/// - note:
/// To get linear algebraic matrix multiplication, use the multiply operator
/// `*`.
public func matrixCompMult<M: GenericMatrix>(_ x: M, _ y: M) -> M {
    return x.zip(y) { $0 * $1 }
}

/// Treats the first parameter `c` as a column vector (matrix with one column)
/// and the second parameter `r` as a row vector (matrix with one row)
/// and does a linear algebraic matrix multiply `c * r`,
/// yielding a matrix whose number of rows is the number of components in `c`
/// and whose number of columns is the number of components in `r`.
public func outerProduct
<
    C: FloatVector,
    R: FloatVector,
    M: GenericMatrix
>(_ c: C, _ r: R) -> M
    where
    // SWIFT BUG: Swift 4 thinks this constraint is redundant and does not
    //            enforce it.
    C.Component == R.Component,
    M.Component == C,
    M.Dim == R.Dim
{
    var m = [C]()
    for i in 0 ..< R.dimension {
        m.append(c * (r[i] as! C.Component))
    }
    return M(m)
}

/// Returns transpose matrix of `m`.
public func transpose(_ m: mat2) -> mat2 {
    return m.transpose
}

/// Returns transpose matrix of `m`.
public func transpose(_ m: mat2x3) -> mat3x2 {
    return m.transpose
}

/// Returns transpose matrix of `m`.
public func transpose(_ m: mat2x4) -> mat4x2 {
    return m.transpose
}

/// Returns transpose matrix of `m`.
public func transpose(_ m: mat3x2) -> mat2x3 {
    return m.transpose
}

/// Returns transpose matrix of `m`.
public func transpose(_ m: mat3) -> mat3 {
    return m.transpose
}

/// Returns transpose matrix of `m`.
public func transpose(_ m: mat3x4) -> mat4x3 {
    return m.transpose
}

/// Returns transpose matrix of `m`.
public func transpose(_ m: mat4x2) -> mat2x4 {
    return m.transpose
}

/// Returns transpose matrix of `m`.
public func transpose(_ m: mat4x3) -> mat3x4 {
    return m.transpose
}

/// Returns transpose matrix of `m`.
public func transpose(_ m: mat4) -> mat4 {
    return m.transpose
}

/// Returns the determinant of `m`.
public func determinant<M: GenericSquareMatrix>(_ m: M) -> M.Component.Component {
    return m.determinant
}

/// Returns a matrix that is the inverse of `m`.
public func inverse<M: GenericSquareMatrix>(_ m: M) -> M {
    return m.inverse
}
