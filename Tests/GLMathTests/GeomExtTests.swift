
import XCTest
import FlatUtil
import simd
@testable import GLMath

class GeomExtTests: XCTestCase {

    func testSquareLength() {
        XCTAssert(quickCheck(Gen<vec3>(), size: 100) { v3 in
            return v3.squareLength ~== simd.length_squared(v3)
        })
    }

    func testProjection() {
        XCTAssert(quickCheck(Gen<vec3>(), Gen<vec3>(), size: 100) { va, vb in
            let v = va.projection(on: vb)
            return length(v) <= length(va) && normalize(v).isClose(to: normalize(vb), tolerance: 1e-6)
        })
    }

    func testIsPerpendicular() {
        XCTAssert(quickCheck(Gen<vec2>(), size: 100) { v2 in
            let v = vec2(-v2.y, v2.x)
            return v2.isPerpendicular(to: v)
        })
    }

    func testAngleBetween() {
        XCTAssertEqual(vec2(1, 0).angle(between: vec2(1, 0)), 0)
        XCTAssertEqual(vec2(1, 0).angle(between: vec2(-1, 0)), .π)
        XCTAssert(vec2(1, 0).angle(between: vec2(0, 1)).isClose(to: .half_pi))
        XCTAssert(quickCheck(Gen<Double>(), size: 100) { d in
            let theta = (d  + 1) * .π * 0.3
            let x = cos(theta)
            let y = sin(theta)
            return dvec2(1, 0).angle(between: dvec2(x, y)) ~== theta
        })
    }
}
