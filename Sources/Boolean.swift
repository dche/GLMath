//
// GLMath - Boolean.swift
//
// Boolean vectors.
//
// Copyright (c) 2017 The GLMath authors.
// Licensed under MIT License.

public struct bvec2: Vector2 {

    public typealias Dim = Dimension2
    public typealias Component = Bool
    public typealias ArrayLiteralElement = Bool

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

public struct bvec3: Vector3 {

    public typealias Dim = Dimension3
    public typealias Component = Bool
    public typealias AssociatedVector2 = bvec2
    public typealias ArrayLiteralElement = Bool

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

public struct bvec4: Vector4 {

    public typealias Dim = Dimension4
    public typealias Component = Bool
    public typealias AssociatedVector2 = bvec2
    public typealias AssociatedVector3 = bvec3
    public typealias ArrayLiteralElement = Bool

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
