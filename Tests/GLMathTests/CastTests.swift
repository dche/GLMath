
import XCTest
@testable import GLMath

class CastTests: XCTestCase {

    func testBoolVector2NumberVector() {
        let b3 = bvec3(true, true, false)
        let i3 = ivec3(b3)
        XCTAssertEqual(i3, ivec3(1, 1, 0))
    }
}
