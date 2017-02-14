//
// GLMath - Boolean.swift
//
// Boolean vectors.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

public protocol BoolVector: Vector, ExpressibleByArrayLiteral {

    associatedtype Component = Bool
}

public struct bvec2: Vector2, BoolVector {

    public typealias Element = Bool

    public var x, y: Bool

    public init (_ x: Bool, _ y: Bool) {
        self.x = x
        self.y = y
    }

    public init (_ components: [Bool]) {
        let x = components.count > 0 ? components[0] : false
        let y = components.count > 1 ? components[1] : false
        self.init(x, y)
    }
}

public struct bvec3: Vector3, BoolVector {

    public typealias Element = Bool
    public typealias AssociatedVector2 = bvec2

    public var x, y, z: Bool

    private let _w = false

    public init (_ x: Bool, _ y: Bool, _ z: Bool) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init (_ components: [Bool]) {
        let x = components.count > 0 ? components[0] : false
        let y = components.count > 1 ? components[1] : false
        let z = components.count > 2 ? components[2] : false
        self.init(x, y, z)
    }
}

public struct bvec4: Vector4, BoolVector {

    public typealias Element = Bool
    public typealias AssociatedVector2 = bvec2
    public typealias AssociatedVector3 = bvec3

    public var x, y, z, w: Bool

    public init (_ x: Bool, _ y: Bool, _ z: Bool, _ w: Bool) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init (_ components: [Bool]) {
        let x = components.count > 0 ? components[0] : false
        let y = components.count > 1 ? components[1] : false
        let z = components.count > 2 ? components[2] : false
        let w = components.count > 3 ? components[3] : false
        self.init(x, y, z, w)
    }
}
