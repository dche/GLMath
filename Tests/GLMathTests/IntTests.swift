
import XCTest
@testable import GLMath

class IntTests: XCTestCase {

    func testNextPowerOf2() {
        XCTAssertEqual(UInt32(11).nextPowerOf2, 16)
    }
}
