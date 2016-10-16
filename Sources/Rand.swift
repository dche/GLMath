//
// GLMath - Rand.swift
//
// `Random` protocol extensions for vector types.
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

import FlatUtil

extension Vector where Self.Component: Random {

    public init (withRng rng: inout Rng) {
        var ary: [Self.Component] = []
        for _ in 0..<Self.dimension {
            ary.append(Self.Component(withRng: &rng))
        }
        self.init(ary)
    }
}
