
import XCTest
@testable import GLMath

class ApproxEquatableTests: XCTestCase {

    func testIsClsoeTo() {
        XCTAssertFalse(1.0.isClose(to: 2.0))
        XCTAssert(1.0.isClose(to: 1.0))
        XCTAssert(1.0.isClose(to: 1.0 + .epsilon))
        XCTAssert(1.0.isClose(to: 1.0 - .epsilon))
        XCTAssertFalse(Float(1).isClose(to: 1 + .epsilon, tolerance: 1e-9))
    }

    func testOperator() {
        XCTAssert(1.0 ~== 1.0 + .epsilon)
        XCTAssertFalse(1.0 ~== 2.0)
    }

    func testApprxEqVector() {
        XCTAssert(vec2(1, 1).isClose(to: vec2(1, 1 + .epsilon)))
    }
}
