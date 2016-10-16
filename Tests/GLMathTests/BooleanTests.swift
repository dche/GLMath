
import XCTest
@testable import GLMath

class BooleanTests: XCTestCase {

    func testInit() {
        let bv2 = bvec2(true, false)
        XCTAssertEqual(bv2.x, true)
        XCTAssertEqual(bv2.y, false)
        let bv3 = bvec3(false, bv2)
        XCTAssertFalse(bv3.x)
        let bv4 = bvec4(bv2, bv2)
        XCTAssertEqual(bv4.xy, bv2)
    }

    func testAll() {
        let bv3 = bvec3(true)
        XCTAssertEqual(all(bv3), true)
        let bv2 = bvec2(false, true)
        XCTAssertEqual(all(bv2), false)
    }

    func testNot() {
        let bv3 = bvec3(false)
        XCTAssertEqual(not(bv3), bvec3(true))
        let bv2 = bvec2(true, false)
        XCTAssertEqual(not(bv2), bvec2(false, true))
    }

    func testAny() {
        XCTAssertFalse(any(bvec4(false)))
        XCTAssert(any(bvec4(bvec3(false), true)))
    }
}
