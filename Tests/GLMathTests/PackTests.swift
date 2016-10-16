
import XCTest
import FlatUtil
@testable import GLMath

class PackTests: XCTestCase {

    func testPackUnpackUnorm2x16() {
        XCTAssertEqual(packUnorm2x16(vec2.zero), 0)
        XCTAssertEqual(packUnorm2x16(vec2(0, 1)), 0xFFFF_0000)
        XCTAssertEqual(unpackUnorm2x16(0xFFFF_0000), vec2(0, 1))
    }

    func testPackUnpackDouble2x32() {
        let u2 = uvec2(1, 2)
        XCTAssertEqual(u2, unpackDouble2x32(packDouble2x32(u2)))
    }
}
