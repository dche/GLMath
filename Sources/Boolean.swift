//
// GLMath - Boolean.swift
//
// Boolean vectors.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import Darwin

public protocol BoolVector: Vector, ExpressibleByArrayLiteral {

    associatedtype Component = Bool
}

public struct bvec2: Vector2, BoolVector {

    public var x, y: Bool

    public subscript (index: Int) -> Bool {
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
            default: ()
            }
        }
    }

    public init (_ x: Bool, _ y: Bool) {
        self.x = x
        self.y = y
    }

    public init(_ components: [Bool]) {
        precondition(components.count == 2, "bvec2 requires a 2-element array.")
        self.init(components[0], components[1])
    }

    public init(arrayLiteral array: Bool...) {
        self.init(array)
    }
}

public struct bvec3: Vector3, BoolVector {

    public typealias AssociatedVector2 = bvec2

    public var x, y, z: Bool

    private let _w = false

    public subscript (index: Int) -> Bool {
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
            default: ()
            }
        }
    }

    public init (_ x: Bool, _ y: Bool, _ z: Bool) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init(_ components: [Bool]) {
        precondition(components.count == 3, "bvec3 requires a 3-element array.")
        self.init(components[0], components[1], components[2])
    }


    public init(arrayLiteral array: Bool...) {
        self.init(array)
    }
}

public struct bvec4: Vector4, BoolVector {

    public typealias AssociatedVector2 = bvec2
    public typealias AssociatedVector3 = bvec3

    public var x, y, z, w: Bool

    public subscript (index: Int) -> Bool {
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
            default: ()
            }
        }
    }

    public init (_ x: Bool, _ y: Bool, _ z: Bool, _ w: Bool) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init(_ components: [Bool]) {
        precondition(components.count == 4, "bvec4 requires a 4-element array.")
        self.init(components[0], components[1], components[2], components[3])
    }

    public init(arrayLiteral array: Bool...) {
        self.init(array)
    }
}
