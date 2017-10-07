//
// GLMath - Vector.swift
//
// `Vector` and `NumericVector` protocols.
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

import FlatUtil

/// `Dimension` protocol and its implementations (e.g., `Dimension2` etc.) are
/// used to encode the form of a type (number of components) into the type
/// system.
public protocol Dimension {
    /// Number of dimensions.
    static var value: Int { get }
}

/// 2 dimensions.
public struct Dimension2: Dimension {
    public static let value = 2
}

/// 3 dimensions.
public struct Dimension3: Dimension {
    public static let value = 3
}

/// 4 dimensions.
public struct Dimension4: Dimension {
    public static let value = 4
}

/// Generic vector type.
public protocol Vector: Equatable, ExpressibleByArrayLiteral {

    /// `Dimension` object represents the dimension of `self`.
    associatedtype Dim: Dimension

    /// Type of components.
    associatedtype Component: Equatable

    subscript (index: Int) -> Component { get set }

    func map(_ fn: (Component) -> Component) -> Self

    func fold<T>(_ initialValue: T, _ fn: (T, Component) -> T) -> T

    func zip(_ y: Self, _ fn: (Component, Component) -> Component) -> Self

    func split(_ fn: (Component) -> (Component, Component)) -> (Self, Self)

    func reduce(_ fn: (Component, Component) -> Component) -> Component

    /// Creates an instance from a value of `Component`. All
    /// components of the new instance have same value of `x`.
    ///
    /// - parameter x: The value for all components.
    ///
    /// ## Example
    /// ```
    /// let v = vec4(2)
    /// assert(v.w == 2)
    /// ```
    init (_ x: Component)

    /// Constructs an instance from a list of values of components.
    ///
    /// It is a serious bug if the `count` of `components` does no equal to
    /// the dimension of `Self`.
    ///
    /// - parameter components: An array contains values of all components.
    ///
    /// # Example
    /// ```
    /// let v = bvec3([true, false, false]
    /// assert(v).y == false)
    /// ```
    init (_ components: [Component])
}

extension Vector {

    /// Returns the dimension of the receiver as a number.
    ///
    /// ## Example
    /// ```
    /// let dim = mat3.dimension
    /// assert(dim == 3)
    /// ```
    public static var dimension: Int {
        return Self.Dim.value
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        for i in 0 ..< Self.dimension {
            if lhs[i] != rhs[i] { return false }
        }
        return true
    }
}

extension Vector where ArrayLiteralElement == Component {

    public init (arrayLiteral: ArrayLiteralElement...) {
        self.init(arrayLiteral)
    }
}

/// Generic type for vectors with `2` components.
public protocol Vector2: Vector {

    associatedtype Dim = Dimension2

    /// The first component.
    var x: Component { get set }

    /// The second component.
    var y: Component { get set }

    init (_ x: Component, _ y: Component)
}

public extension Vector2 {

    init (_ x: Component) {
        self.init(x, x)
    }

    public subscript (index: Int) -> Component {
        get {
            switch index {
            case 0: return x
            case 1: return y
            default: fatalError("Index out of range 0...1.")
            }
        }
        set {
            switch index {
            case 0: x = newValue
            case 1: y = newValue
            default: break
            }
        }
    }

    func map(_ fn: (Component) -> Component) -> Self {
        return Self.init(fn(self.x), fn(self.y))
    }

    func zip(_ y: Self, _ fn: (Component, Component) -> Component) -> Self {
        let nx = fn(self.x, y.x)
        let ny = fn(self.y, y.y)
        return Self.init(nx, ny)
    }

    func split(_ fn: (Component) -> (Component, Component)) -> (Self, Self) {
        let (x0, x1) = fn(self.x)
        let (y0, y1) = fn(self.y)
        return (Self.init(x0, y0), Self.init(x1, y1))
    }

    func fold<T>(_ initialValue: T, _ fn: (T, Component) -> T) -> T {
        return fn(fn(initialValue, self.x), self.y)
    }

    func reduce(_ fn: (Component, Component) -> Component) -> Component {
        return fn(self.x, self.y)
    }
}

/// Generic type for vectors with `3` components.
public protocol Vector3: Vector
    where
    Component == AssociatedVector2.Component
{
    associatedtype Dim = Dimension3

    associatedtype AssociatedVector2: Vector2

    /// The first component.
    var x: Component { get set }

    /// The second component.
    var y: Component { get set }

    /// The third component.
    var z: Component { get set }

    init (_ x: Component, _ y: Component, _ z: Component)
}

public extension Vector3 {

    init (_ x: Component) {
        self.init(x, x, x)
    }

    init (_ xy: AssociatedVector2, _ z: Component) {
        self.init(xy.x, xy.y, z)
    }

    init (_ x: Component, _ yz: AssociatedVector2) {
        self.init(x, yz.x, yz.y)
    }

    public subscript (index: Int) -> Component {
        get {
            switch index {
            case 0: return x
            case 1: return y
            case 2: return z
            default: fatalError("Index out of range 0...2.")
            }
        }
        set {
            switch index {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            default: break
            }
        }
    }

    func map(_ fn: (Component) -> Component) -> Self {
        return Self.init(fn(self.x), fn(self.y), fn(self.z))
    }

    func zip(_ y: Self, _ fn: (Component, Component) -> Component) -> Self {
        let nx = fn(self.x, y.x)
        let ny = fn(self.y, y.y)
        let nz = fn(self.z, y.z)
        return Self.init(nx, ny, nz)
    }

    func split(_ fn: (Component) -> (Component, Component)) -> (Self, Self) {
        let (x0, x1) = fn(self.x)
        let (y0, y1) = fn(self.y)
        let (z0, z1) = fn(self.z)
        return (Self.init(x0, y0, z0), Self.init(x1, y1, z1))
    }

    func fold<T>(_ initialValue: T, _ fn: (T, Component) -> T) -> T {
        return fn(fn(fn(initialValue, self.x), self.y), self.z)
    }

    func reduce(_ fn: (Component, Component) -> Component) -> Component {
        return fn(fn(self.x, self.y), self.z)
    }
}

/// Generic type for vectors with `4` components.
public protocol Vector4: Vector
    where
    Component == AssociatedVector2.Component,
    Component == AssociatedVector3.Component
{
    associatedtype Dim = Dimension4

    associatedtype AssociatedVector2: Vector2

    associatedtype AssociatedVector3: Vector3

    /// The first component.
    var x: Component { get set }

    /// The second component.
    var y: Component { get set }

    /// The third component.
    var z: Component { get set }

    /// The fourth component.
    var w: Component { get set }

    init (_ x: Component, _ y: Component, _ z: Component, _ w: Component)
}

public extension Vector4 {

    init (_ x: Component) {
        self.init(x, x, x, x)
    }

    init (_ xyz: AssociatedVector3, _ w: Component) {
        self.init(xyz.x, xyz.y, xyz.z, w)
    }

    init (_ x: Component, _ yzw: AssociatedVector3) {
        self.init(x, yzw.x, yzw.y, yzw.z)
    }

    init (_ xy: AssociatedVector2, _ zw: AssociatedVector2) {
        self.init(xy.x, xy.y, zw.x, zw.y)
    }

    init (_ xy: AssociatedVector2, _ z: Component, _ w: Component) {
        self.init(xy.x, xy.y, z, w)
    }

    init (_ x: Component, _ y: Component, _ zw: AssociatedVector2) {
        self.init(x, y, zw.x, zw.y)
    }

    init (_ x: Component, _ yz: AssociatedVector2, _ w: Component) {
        self.init(x, yz.x, yz.y, w)
    }

    public subscript (index: Int) -> Component {
        get {
            switch index {
            case 0: return x
            case 1: return y
            case 2: return z
            case 3: return w
            default: fatalError("Index out of range 0...3.")
            }
        }
        set {
            switch index {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            case 3: w = newValue
            default: break
            }
        }
    }

    func map(_ fn: (Component) -> Component) -> Self {
        return Self.init(fn(self.x), fn(self.y), fn(self.z), fn(self.w))
    }

    func zip(_ y: Self, _ fn: (Component, Component) -> Component) -> Self {
        let nx = fn(self.x, y.x)
        let ny = fn(self.y, y.y)
        let nz = fn(self.z, y.z)
        let nw = fn(self.w, y.w)
        return Self.init(nx, ny, nz, nw)
    }

    func split(_ fn: (Component) -> (Component, Component)) -> (Self, Self) {
        let (x0, x1) = fn(self.x)
        let (y0, y1) = fn(self.y)
        let (z0, z1) = fn(self.z)
        let (w0, w1) = fn(self.w)
        return (Self.init(x0, y0, z0, w0), Self.init(x1, y1, z1, w1))
    }

    func fold<T>(_ initialValue: T, _ fn: (T, Component) -> T) -> T {
        return fn(fn(fn(fn(initialValue, self.x), self.y), self.z), self.w)
    }

    func reduce(_ fn: (Component, Component) -> Component) -> Component {
        return fn(fn(fn(self.x, self.y), self.z), self.w)
    }
}

/// Generic number vector type.
public protocol NumericVector: GenericNumber, Vector
    where
    Component: BaseNumber,
    AssociatedBooleanVector.Component == Bool,
    AssociatedBooleanVector.Dim == Self.Dim
{
    associatedtype AssociatedBooleanVector: Vector

    static func + (lhs: Self, rhs: Component) -> Self

    static func * (lhs: Self, rhs: Component) -> Self

    static func / (lhs: Self, rhs: Component) -> Self

    static func + (lhs: Component, rhs: Self) -> Self

    static func * (lhs: Component, rhs: Self) -> Self

    static func / (lhs: Component, rhs: Self) -> Self

    /// The sum of all components.
    ///
    /// ## Example
    /// ```
    /// assert(vec3(1, 2, 3).sum == 6)
    /// ```
    var sum: Component { get }

    /// The multiplies of all components.
    ///
    /// ## Example
    /// ```
    /// assert(vec3(2).product == 8)
    /// ```
    var product: Component { get }

    /// The minimal value among all components.
    ///
    /// ## Example
    /// ```
    /// assert(vec3(1, 2, 3).min == 1)
    /// ```
    var min: Component { get }

    /// The maximal value among all components.
    ///
    /// ## Example
    /// ```
    /// assert(vec3(1, 2, 3).max == 3)
    /// ```
    var max: Component { get }
}

extension NumericVector {

    public static var zero: Self { return Self.init(Component.zero) }

    public static var one: Self { return Self.init(Component.one) }

    public static func + (lhs: Self, rhs: Component) -> Self {
        return lhs + Self.init(rhs)
    }

    public static func * (lhs: Self, rhs: Component) -> Self {
        return lhs * Self.init(rhs)
    }

    public static func / (lhs: Self, rhs: Component) -> Self {
        return lhs / Self.init(rhs)
    }

    public static func + (lhs: Component, rhs: Self) -> Self {
        return rhs + lhs
    }

    public static func * (lhs: Component, rhs: Self) -> Self {
        return rhs * lhs
    }

    public static func / (lhs: Component, rhs: Self) -> Self {
        return rhs / lhs
    }

    public var sum: Component {
        return fold(Component.zero, +)
    }

    public var product: Component {
        return fold(Component.one, *)
    }

    public var min: Component {
        return reduce { $1 < $0 ? $1 : $0 }
    }

    public var max: Component {
        return reduce { $1 > $0 ? $1 : $0 }
    }
}

extension NumericVector where Self: GenericSignedNumber {

    public static func - (lhs: Self, rhs: Component) -> Self {
        return lhs - Self.init(rhs)
    }

    public static func - (lhs: Component, rhs: Self) -> Self {
        return Self.init(lhs) - rhs
    }
}
