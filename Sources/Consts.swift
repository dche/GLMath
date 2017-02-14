//
// GLMath - Consts.swift
//
// Copyright (c) 2016 The GLMath authors.
// Licensed under MIT License.

public extension BaseFloat {

    static var infinity: Self {
        return .infinity
    }

    static var epsilon: Self {
        return Self(1).ulp
    }

    static var pi: Self {
        return 3.14159265358979323846264338327950288
    }

    static var π: Self {
        return pi
    }

    static var tau: Self {
        return 6.28318530717958647692528676655900576
    }

    static var root_pi: Self {
        return 1.772453850905516027
    }

    static var half_pi: Self {
        return 1.57079632679489661923132169163975144
    }

    static var one_third_pi: Self {
        return 1.04719755119659774615421446109316763
    }

    static var quarter_pi: Self {
        return 0.785398163397448309615660845819875721
    }

    static var one_over_pi: Self {
        return 0.318309886183790671537767526745028724
    }

    static var one_over_tau: Self {
        return 0.159154943091895335768883763372514362
    }

    static var two_over_pi: Self {
        return 0.636619772367581343075535053490057448
    }

    static var four_over_pi: Self {
        return 1.273239544735162686151070106980114898
    }

    static var two_over_root_pi: Self {
        return 1.12837916709551257389615890312154517
    }

    static var one_over_root_two: Self {
        return 0.707106781186547524400844362104849039
    }

    static var root_half_pi: Self {
        return 1.253314137315500251
    }

    static var root_tau: Self {
        return 2.506628274631000502
    }

    static var root_ln_four: Self {
        return 1.17741002251547469
    }

    static var e: Self {
        return 2.71828182845904523536028747135266250
    }

    static var euler: Self {
        return 0.577215664901532860606
    }

    static var root_two: Self {
        return 1.41421356237309504880168872420969808
    }

    static var root_three: Self {
        return 1.73205080756887729352744634150587236
    }

    static var root_five: Self {
        return 2.23606797749978969640917366873127623
    }

    static var ln_two: Self {
        return 0.693147180559945309417232121458176568
    }

    static var ln_ten: Self {
        return 2.30258509299404568401799145468436421
    }

    static var ln_ln_two: Self {
        return -0.3665129205816643
    }

    static var one_third: Self {
        return 0.3333333333333333333333333333333333333333
    }

    static var two_thirds: Self {
        return 0.666666666666666666666666666666666666667
    }

    static var phi: Self {
        return 1.61803398874989484820458683436563811
    }

    static var one_over_255: Self {
        return 0.0039215686274509803921568627451
    }
}

public extension FloatVector {

    static var infinity: Self {
        return Self.init(Self.Component.infinity)
    }

    static var pi: Self {
        return Self.init(Self.Component.pi)
    }

    static var π: Self {
        return self.pi
    }

    static var tau: Self {
        return Self.init(Self.Component.tau)
    }

    static var root_pi: Self {
        return Self.init(Self.Component.root_pi)
    }

    static var half_pi: Self {
        return Self.init(Self.Component.half_pi)
    }

    static var one_third_pi: Self {
        return Self.init(Self.Component.one_third_pi)
    }

    static var quarter_pi: Self {
        return Self.init(Self.Component.quarter_pi)
    }

    static var one_over_pi: Self {
        return Self.init(Self.Component.one_over_pi)
    }

    static var one_over_tau: Self {
        return Self.init(Self.Component.one_over_tau)
    }

    static var two_over_pi: Self {
        return Self.init(Self.Component.two_over_pi)
    }

    static var four_over_pi: Self {
        return Self.init(Self.Component.four_over_pi)
    }

    static var two_over_root_pi: Self {
        return Self.init(Self.Component.two_over_root_pi)
    }

    static var one_over_root_two: Self {
        return Self.init(Self.Component.one_over_root_two)
    }

    static var root_half_pi: Self {
        return Self.init(Self.Component.root_half_pi)
    }

    static var root_tau: Self {
        return Self.init(Self.Component.root_tau)
    }

    static var root_ln_four: Self {
        return Self.init(Self.Component.root_ln_four)
    }

    static var e: Self {
        return Self.init(Self.Component.e)
    }

    static var euler: Self {
        return Self.init(Self.Component.euler)
    }

    static var root_two: Self {
        return Self.init(Self.Component.root_two)
    }

    static var root_three: Self {
        return Self.init(Self.Component.root_three)
    }

    static var root_five: Self {
        return Self.init(Self.Component.root_five)
    }

    static var ln_two: Self {
        return Self.init(Self.Component.ln_two)
    }

    static var ln_ten: Self {
        return Self.init(Self.Component.ln_ten)
    }

    static var ln_ln_two: Self {
        return Self.init(self.Component.ln_ln_two)
    }

    static var one_third: Self {
        return Self.init(Self.Component.one_third)
    }

    static var two_thirds: Self {
        return Self.init(Self.Component.two_thirds)
    }

    static var phi: Self {
        return Self.init(Self.Component.phi)
    }

    static var one_over_255: Self {
        return Self.init(self.Component.one_over_255)
    }
}
