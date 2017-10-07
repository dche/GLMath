
import XCTest
@testable import GLMath

class VectorTests: XCTestCase {

    func testDim() {
        XCTAssertEqual(bvec2.dimension, 2)
        XCTAssertEqual(uvec3.dimension, 3)
    }

    func testInitializer() {
        let v0 = uvec3(1)
        let v1 = uvec3(1, 2, 3)
        let v2 = uvec3(uvec2(3), 2)
        XCTAssertEqual(v0.sum, 3)
        XCTAssertEqual(v1[1], 2)
        XCTAssertEqual(v2[0], 3)
        XCTAssertEqual(v0.product, 1)
        XCTAssertEqual(v1.min, 1)
        XCTAssertEqual(v2.product, 18)
        let v3 = uvec3(2, uvec2(3))
        XCTAssertEqual(v3.z, 3)
        XCTAssertEqual(v3.sum, 8)
        let v4 = uvec4(5)
        XCTAssertEqual(v4, uvec4(5, 5, 5, 5))
        let v5 = uvec4(uvec2(0), uvec2(1))
        XCTAssertEqual(v5, uvec4(0, 0, 1, 1))
        let v6 = uvec4(1, uvec2(0), 3)
        XCTAssertEqual(v6, uvec4(1, 0, 0, 3))
        let v7 = uvec4(v2, 7)
        XCTAssertEqual(v7, uvec4(3, 3, 2, 7))
        let v8 = uvec4(8, v3)
        XCTAssertEqual(v8, uvec4(8, 2, 3, 3))
    }

    func testMinusVS() {
        let v0 = vec3(1,2,3)
        XCTAssertEqual(v0 - 1, vec3(0,1,2))
        XCTAssertEqual(4 - v0, vec3(3,2,1))
    }
}
