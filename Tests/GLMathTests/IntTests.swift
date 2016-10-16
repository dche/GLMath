
import XCTest
import simd
@testable import GLMath

class IntTests: XCTestCase {

    func testNextPow2() {
        XCTAssertEqual(Int32(11).nextPow2, 16)
    }
}
