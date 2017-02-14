
#if os(Linux)
    import Glibc
#else
    import simd
#endif

import XCTest
@testable import GLMath

class MatTests: XCTestCase {

    func testMatrixCompMult() {
        let m1 = mat3x2(vec2(1, 4), vec2(2, 5), vec2(3, 6))
        let m2 = mat3x2(vec2(2, 3), vec2(2, 3), vec2(2, 3))
        let me = mat3x2(vec2(2, 12), vec2(4, 15), vec2(6, 18))
        XCTAssertEqual(matrixCompMult(m1, m2), me)
    }

    func testOuterProduct() {
        let v1 = dvec2(1, 2)
        let v2 = dvec3(3, 4, 5)
        let m: dmat3x2 = outerProduct(v1, v2)
        XCTAssertEqual(m.x, dvec2(3, 6))
    }
}
