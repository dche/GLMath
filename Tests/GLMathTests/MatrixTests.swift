
import XCTest
import simd
@testable import GLMath

class MatrixTests: XCTestCase {

    func testInitializer() {
        let m2 = mat2(1, 2, 3, 4)
        XCTAssertEqual(m2.x, vec2(1, 2))
        XCTAssertEqual(m2.y, vec2(3, 4))
    }

    func testSubscriptAccess() {
        let m = mat4x3(1, 2, 3, 2, 4, 6, 3, 6, 9, 4, 8, 12)
        XCTAssertEqual(m[3], vec3(4, 8, 12))
        XCTAssertEqual(m[1], m.y)
        XCTAssertEqual(m[2][0], 3)
        XCTAssertEqual(m[0][1], m[0, 1])
    }

    func testMulMM() {
        let m43 = mat4x3(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1)
        let m24 = mat2x4(2, 3, 4, 5, 6, 7, 8, 9)
        let m0 = m43 * m24
        XCTAssertEqual(m0, mat2x3(78, 42, 56, 150, 90, 120))
        let m3a = mat3(1, 2, 3, 4, 5, 6, 7, 8, 9)
        let m3b = mat3(10, 11, 12, 13, 14, 15, 16, 17, 18)
        XCTAssertEqual(m3a * m3b, mat3(138, 171, 204, 174, 216, 258, 210, 261, 312))
    }

    func testPerformanceMulMM() {
        let m43 = mat4x3(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1)
        let m24 = mat2x4(2, 3, 4, 5, 6, 7, 8, 9)
        let _ = m43 * m24
        self.measure {
            let _ = m43 * m24
        }
    }

    func testReferencePerformanceMulMM() {
        let m43 = mat4x3(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1)
        let f43 = float4x3([m43.x, m43.y, m43.z, m43.w])
        let m24 = mat2x4(2, 3, 4, 5, 6, 7, 8, 9)
        let f24 = float2x4([m24.x, m24.y])
        let _ = f43 * f24
        self.measure {
            let _ = f43 * f24
        }
    }

    func testMulMV() {
        let m = mat2x3(1, 2, 3, 4, 5, 6)
        let v = vec2(7, 8)
        let mul = m * v
        XCTAssertEqual(mul, vec3(39, 54, 69))
    }

    func testMulVM() {
        let m = mat2x3(1, 2, 3, 4, 5, 6)
        let v = vec3(7, 8, 9)
        XCTAssertEqual(v * m, vec2(50, 122))
    }

    func testMat2Inverse() {
        let m = mat2(1, 2, 3, 4)
        let m2 = float2x2([m.x, m.y])
        let mi = m.inverse
        let mi2 = m2.inverse.cmatrix
        XCTAssertEqual(mi.x, mi2.columns.0)
        XCTAssertEqual(mi.y, mi2.columns.1)
    }

    func testMat3Inverse() {
        let i = mat3.identity
        XCTAssertEqual(i.inverse, i)
        let m = mat3(5, 7, 11, -6, 9, 2, 1, 13, 0)
        let f33 = float3x3([m.x, m.y, m.z])
        let mi = m.inverse
        let mi3 = f33.inverse.cmatrix
        XCTAssertEqual(mi.x, mi3.columns.0)
        XCTAssertEqual(mi.y, mi3.columns.1)
        XCTAssertEqual(mi.z, mi3.columns.2)
    }
}
