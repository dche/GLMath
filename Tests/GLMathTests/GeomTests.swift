
import XCTest
import FlatUtil
@testable import GLMath
import simd

class GeomTests: XCTestCase {

    func testLength() {
        let v = vec3(3, 4, 0)
        XCTAssertEqual(length(v), 5)
    }

    func testDistance() {
        XCTAssert(quickCheck(Gen<vec2>(), Gen<vec2>(), size: 10) { v0, v1 in
            XCTAssertEqualWithAccuracy(distance(v0, v1), length(v0 - v1), accuracy: Float.epsilon)
            return true
        })
    }

    func testDot() {
        let v0 = vec3.one
        let v1 = vec3.zero
        XCTAssertEqual(0, dot(v0, v1))
    }

    func testCross() {
        let x = vec3(1, 0, 0)
        let y = vec3(0, 1, 0)
        let z = vec3(0, 0, 1)
        XCTAssertEqual(cross(x, y), z)
    }

    func testNormalize() {
        let v = vec2(0.6, 0.8)
        let n = normalize(vec2(3, 4))
        XCTAssertEqualWithAccuracy(v.x, n.x, accuracy: Float.epsilon)
        XCTAssertEqualWithAccuracy(v.y, n.y, accuracy: Float.epsilon)
    }
}
