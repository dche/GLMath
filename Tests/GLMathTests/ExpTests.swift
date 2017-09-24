
#if os(Linux)
    import Glibc
#else
    import simd
#endif

import XCTest
@testable import GLMath

class ExpTests: XCTestCase {

    func testPow() {
        XCTAssertEqual(pow(2.0, 3.0), 8)
        let v1 = vec3(1, 2, 3)
        let v2 = vec3(1, 4, 27)
        XCTAssertEqual(pow(v1, v1), v2)
    }

    func testExp() {
        let e1 = dvec2(Double.e)
        let e2 = e1 * e1
        XCTAssertEqual(exp(2.0), e2.x, accuracy: Double.epsilon * 10)
    }

    func testLog() {
        let e1 = vec4(Float.e)
        let e2 = e1 * e1
        XCTAssertEqual(log(e2).z, 2)
    }

    func testExp2() {
        XCTAssertEqual(exp2(vec2(-1, 5)), vec2(0.5, 32))
    }

    func testLog2() {
        XCTAssertEqual(log2(vec2(64, 256)), vec2(6, 8))
    }

    func testSqrt() {
        XCTAssertEqual(sqrt(vec2(64, 1)), vec2(8, 1))
    }

    func testInversesqrt() {
        XCTAssertEqual(inversesqrt(vec2(64, 1)).x, 0.125, accuracy: Float.epsilon)
    }
}
