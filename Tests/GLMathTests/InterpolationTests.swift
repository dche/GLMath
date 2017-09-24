
import XCTest
import FlatUtil
@testable import GLMath

class InterpolationTests: XCTestCase {

    func testLerp() {
        XCTAssertEqual(1.0.interpolate(2.0, t: 0), 1)
        XCTAssertEqual(1.0.interpolate(2.0, t: 1), 2)
        XCTAssertEqual(1.0.interpolate(2.0, t: 0.5), 1.5)

        XCTAssert(quickCheck(Gen<vec3>(), Gen<vec3>(), Gen<Float>(), size: 100) { va, vb, c in
            return va.interpolate(vb, t: c) == mix(va, vb, c)
        })
    }

    func testSlerp() {
        let a = vec2(1, 0)
        let b = vec2(0, 1)
        XCTAssert(a.slerp(b, t: 0.5).length ~== 1)
    }
}
