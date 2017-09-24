
#if os(Linux)
    import Glibc
#else
    import simd
#endif

import XCTest
import FlatUtil
@testable import GLMath

class CommonTests: XCTestCase {

    func testAbs() {
        XCTAssertEqual(abs(Float(-1)), 1)
        let v4 = vec4(0, 100, -2, -3)
        XCTAssertEqual(abs(v4), vec4(0, 100, 2, 3))
    }

    func testSign() {
        XCTAssertEqual(sign(Float(0)), 0)
        let v3 = vec3(-100, 2, 0)
        XCTAssertEqual(sign(v3), vec3(-1, 1, 0))
        XCTAssertEqual(sign(ivec3(-100, 0, 3)), ivec3(-1, 0, 1))
    }

    func testFloor() {
        XCTAssertEqual(floor(-3.14), -4)
        let v3 = vec3(-1.7, 4, 4.9)
        XCTAssertEqual(floor(v3), vec3(-2, 4, 4))
    }

    func testTrunc() {
        XCTAssertEqual(trunc(-3.14), -3)
        let v3 = vec3(-1.7, 4, 4.9)
        XCTAssertEqual(trunc(v3), vec3(-1, 4, 4))
    }

    func testRound() {
        XCTAssertEqual(round(-3.14), -3)
        let v3 = vec3(-1.7, 4, 4.9)
        XCTAssertEqual(round(v3), vec3(-2, 4, 5))
    }

    func testRoundEven() {
        var re = roundEven(2.5)
        XCTAssertEqual(2, re)
        re = roundEven(1.5)
        XCTAssertEqual(2, re)
        XCTAssertEqual(
            roundEven(vec4(3.14, -3.14, -1.5, -2.5)),
            vec4(3, -3, -2, -2)
        )
    }

    func testCeil() {
        XCTAssertEqual(ceil(-3.14), -3)
        XCTAssertEqual(ceil(3.14), 4)
        XCTAssertEqual(ceil(dvec3(-1.8, 1, 1.8)), ceil(dvec3(-1, 1, 2)))
    }

    func testFract() {
        XCTAssertEqual(fract(3.25), 0.25)
        XCTAssertEqual(fract(vec2(-1.5, 1)), vec2(0.5, 0))
    }

    func testMod() {
        let mr = mod(3.5, 3)
        XCTAssertEqual(mr, 0.5)
        let v3 = vec3(-1.5, 1.5, 10.5)
        XCTAssertEqual(mod(v3, vec3(2)), vec3(-1.5, 1.5, 0.5))
    }

    func testModVS() {
        let v3 = vec3(-1.5, 1.5, 10.5)
        XCTAssertEqual(mod(v3, 2), vec3(-1.5, 1.5, 0.5))
    }

    func testModf() {
        let mr = modf(1.5)
        let er = (1.0, 0.5)
        XCTAssert(mr.0 == er.0 && mr.1 == er.1)
        let mvr = modf(vec3(0, -1.25, 3.75))
        let evr = (vec3(0, -1, 3), vec3(0, -0.25, 0.75))
        XCTAssert(mvr.0 == evr.0 && mvr.1 == evr.1)
    }

    func testMin() {
        let mr = min(1.0, 2)
        XCTAssertEqual(1, mr)
        let mvr = min(vec2(1, 4), vec2(2, 3))
        XCTAssertEqual(mvr, vec2(1, 3))
    }

    func testMinVS() {
        let v2 = vec2(1, 3)
        let mr = min(v2, 2)
        XCTAssertEqual(mr, vec2(1, 2))
    }

    func testMax() {
        let mr = max(1.0, 2)
        XCTAssertEqual(2, mr)
        let mvr = max(vec2(1, 4), vec2(2, 3))
        XCTAssertEqual(mvr, vec2(2, 4))
    }

    func testMaxVS() {
        let v2 = vec2(1, 3)
        let mr = max(v2, 2)
        XCTAssertEqual(mr, vec2(2, 3))
    }

    func testClamp() {
        let s = 1.2
        let c = clamp(s, 0, 1)
        XCTAssertEqual(c, 1)
    }

    func testClampVV() {
        let v = vec3(0, 1, 2)
        let min = vec3.zero
        let max = vec3.one
        let c = clamp(v, min, max)
        XCTAssertEqual(c, vec3(0, 1, 1))
    }

    func testClamVS() {
        let v = vec3(0, 1, 2)
        let c = clamp(v, 0, 1)
        XCTAssertEqual(c, vec3(0, 1, 1))
    }

    func testMix() {
        let mr = mix(0, 1, 0.5)
        XCTAssertEqual(mr, 0.5)
        let x = vec2(1, 2)
        let y = vec2(3, 4)
        let t = vec2(0.5, 2)
        let vr = mix(x, y, t)
        XCTAssertEqual(vr, vec2(2, 6))
    }

    func testMixVS() {
        let x = dvec3(10, 20, 30)
        let y = dvec3(100, 200, 300)
        let mr = mix(x, y, 0.5)
        XCTAssertEqual(mr, dvec3(55, 110, 165))
    }

    func testMixVB() {
        let a = bvec4(true, false, false, true)
        let x = dvec4(1, 1, 1, 1)
        let y = dvec4(2, 2, 2, 2)
        let r = mix(x, y, a)
        XCTAssertEqual(r, dvec4(2, 1, 1, 2))
        // works for scalars too.
        let r2 = mix(1.0, 2.0, false)
        XCTAssertEqual(r2, 1)
    }

    func testStep() {
        XCTAssertEqual(step(1.0, 1), 1);
        XCTAssertEqual(step(2.0, 1), 0);
        XCTAssertEqual(step(vec2(1, 2), vec2(2, 1)), vec2(1, 0));
    }

    func testStepVS() {
        XCTAssertEqual(step(0, vec3(-1, 0, 1)), vec3(0, 1, 1))
    }

    func testSmoothstep() {
        XCTAssertEqual(smoothstep(0.0, 1, -1), 0)
        let e0 = dvec2(0, -100)
        let e1 = dvec2(1, 100)
        let v = dvec2(1, 50)
        XCTAssertEqual(smoothstep(e0, e1, v), dvec2(1, 0.84375))
    }

    func testSmoothstepVS() {
        let v = vec3(-100, 50, 150)
        XCTAssertEqual(smoothstep(-100, 100, v), vec3(0, 0.84375, 1))
    }

    func testIsNaN() {
        let nan = Float.nan
        XCTAssert(isnan(nan))
        let v = vec3(nan, 1, -0)
        let bv: bvec3 = isnan(v)
        XCTAssertEqual(bv, bvec3(true, false, false))
    }

    func testIsInf() {
        let inf = Float.infinity
        XCTAssert(isinf(inf))
        let v2 = vec2(inf, 0)
        let bv: bvec2 = isinf(v2)
        XCTAssertEqual(bv, bvec2(true, false))
    }

    func testFloatBitsToInt() {
        let i = floatBitsToInt(1)
        XCTAssertEqual(i, 0x3F800000)
        let v = vec3(0.2, 0, Float.infinity)
        let iv: ivec3 = floatBitsToInt(v)
        XCTAssertEqual(iv, ivec3(0x3E4CCCCD, 0, 0x7f800000))
    }

    func testFloatBitsToUint() {
        let i = floatBitsToUint(1)
        XCTAssertEqual(i, 0x3F800000)
        let v = vec3(0.2, 0, Float.infinity)
        let iv: uvec3 = floatBitsToUint(v)
        XCTAssertEqual(iv, uvec3(0x3E4CCCCD, 0, 0x7f800000))
    }

    func testIntBitsToFloat() {
        let i: Int32 = 0x3F800000
        let f = intBitsToFloat(i)
        XCTAssertEqual(f, 1)
        let vi = ivec3(0x3E4CCCCD, 0, 0x7f800000)
        let vf: vec3 = intBitsToFloat(vi)
        XCTAssertEqual(vf, vec3(0.2, 0, Float.infinity))
    }

    func testUIntBitsToFloat() {
        let u: UInt32 = 0x3F800000
        let f = uintBitsToFloat(u)
        XCTAssertEqual(f, 1)
        let vu = uvec3(0x3E4CCCCD, 0, 0x7f800000)
        let vf: vec3 = uintBitsToFloat(vu)
        XCTAssertEqual(vf, vec3(0.2, 0, Float.infinity))
    }

    func testFma() {
        XCTAssert(quickCheck(Gen<Float>(), Gen<Float>(), Gen<Float>(), size: 100) { a, b, c in
            XCTAssertEqual(fma(a, b, c), a * b + c, accuracy: Float.epsilon)
            return true
        })
        let v = { (a: vec3, b: vec3, c: vec3) -> Bool in
            return fma(a, b, c) == a * b + c
        }
        let qc = quickCheck(Gen<vec3>(), Gen<vec3>(), Gen<vec3>(), size: 100, spec: v)
        XCTAssert(qc)
    }

    func testFrexp() {
        let (a, b) = frexp(Float(0))
        XCTAssertEqual(a, 0)
        XCTAssertEqual(b, 0)
        let v3 = dvec3(1024, 1, 3)
        let s = dvec3(0.5, 0.5, exp2(log2(3) - 2))
        let e = ivec3(11, 1, 2)
        let (c, d): (dvec3, ivec3) = frexp(v3)
        XCTAssertEqual(s, c)
        XCTAssertEqual(e, d)
    }

    func testLdexp() {
        XCTAssertEqual(ldexp(Float(2), 2), 8)
        let vf = vec3(1, 2, 3)
        let vi = ivec3(-1, 1, 2)
        XCTAssertEqual(ldexp(vf, vi), vec3(0.5, 4, 12))
    }
}
