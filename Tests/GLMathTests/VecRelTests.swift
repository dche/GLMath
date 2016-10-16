
import XCTest
@testable import GLMath

class VecRelTests: XCTestCase {

    func testLessThan() {
        let a = ivec4(1, 2, 3, 4)
        let b = ivec4(2, 3, 4, 5)
        XCTAssertEqual(lessThan(b, a), bvec4(false, false, false, false))
        let bv: bvec4 = lessThan(a, b)
        XCTAssert(all(bv))
    }

    func testLessThanEqual() {
        let a = ivec4(1, 2, 3, 4)
        let b = ivec4(2, 2, 3, 3)
        let b4: bvec4 = lessThanEqual(a, b)
        XCTAssertEqual(b4, bvec4(true, true, true, false))
        XCTAssertEqual(b4, not(greaterThan(a, b)))
    }

    func testGreaterThan() {
        let a = ivec4(1, 2, 3, 4)
        let b = ivec4(2, 2, 3, 3)
        let b4: bvec4 = greaterThan(a, b)
        XCTAssertEqual(b4, bvec4(false, false, false, true))
        XCTAssertEqual(b4, lessThan(b, a))
    }

    func testGreaterThanEqual() {
        let a = ivec4(1, 2, 3, 4)
        let b = ivec4(2, 2, 3, 3)
        let b4: bvec4 = greaterThanEqual(a, b)
        XCTAssertEqual(b4, bvec4(false, true, true, true))
        XCTAssertEqual(b4, lessThanEqual(b, a))
        XCTAssertEqual(b4, not(lessThan(a, b)))
    }

    func testEqual() {
        let a = ivec4(1, 2, 3, 4)
        let b = ivec4(2, 2, 3, 3)
        let b4: bvec4 = equal(a, b)
        XCTAssertEqual(b4, bvec4(false, true, true, false))
        XCTAssertEqual(b4, equal(b, a))
        XCTAssert(any(b4))
    }

    func testNotEqual() {
        let a = ivec4(1, 2, 3, 4)
        let b = ivec4(2, 2, 3, 3)
        let b4: bvec4 = notEqual(a, b)
        XCTAssertEqual(b4, bvec4(true, false, false, true))
        XCTAssertEqual(b4, not(equal(b, a)))
    }
}
