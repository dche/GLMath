
import XCTest
@testable import GLMath

class CastTests: XCTestCase {

    func testBoolVector2NumericVector() {
        let b3 = bvec3(true, true, false)
        let i3 = ivec3(b3)
        XCTAssertEqual(i3, ivec3(1, 1, 0))
    }

    func testNumericVector2BoolVector() {
        let v4 = ivec4(1,0,-1,0)
        let b4 = bvec4(v4)
        XCTAssertEqual(b4, bvec4(true,false,true,false))
    }
}
