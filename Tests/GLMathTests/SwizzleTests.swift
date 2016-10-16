
import XCTest
@testable import GLMath

class SwizzleTests: XCTestCase {

    func testSwizzle2() {
        let v4 = vec4(1, 2, 3, 4)
        XCTAssertEqual(v4.yz, vec2(2, 3))
    }

    func testSwizzle3() {
        let v4 = vec4(0.5, 0.25, 0.125, 1.0)
        XCTAssertEqual(v4.rgb, vec3(0.5, 0.25, 0.125))
    }
}
