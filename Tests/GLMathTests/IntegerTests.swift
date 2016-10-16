
import XCTest
@testable import GLMath

class IntegerTests: XCTestCase {

    func testUaddCarry() {
        let v = uvec2(0xFFFF_FFFE, 0)
        let o = uaddCarry(v, uvec2(3, 3))
        let e = (uvec2(1, 3), uvec2(1, 0))
        XCTAssertEqual(o.0, e.0)
        XCTAssertEqual(o.1, e.1)
    }

    func testUsubBorrow() {
        let uv1 = uvec2(16, 17)
        let uv2 = uvec2(17, 16)
        let o = usubBorrow(uv1, uv2)
        let e = (uvec2(0xFFFF_FFFE, 1), uvec2(1, 0))
        XCTAssertEqual(o.0, e.0)
        XCTAssertEqual(o.1, e.1)
    }

    func testUmulExtended() {
        let u1: UInt32 = 0xFFFF_2222
        let u2: UInt32 = 2
        let (lsb, msb) = umulExtended(u1, u2)
        XCTAssertEqual(lsb, 0xFFFE_4444)
        XCTAssertEqual(msb, 1)
    }

    func testImulExtended() {
        let u1: Int32 = 0x7FFF_2222
        let u2: Int32 = 4
        let (_, msb) = imulExtended(u1, u2)
        XCTAssertEqual(msb, 1)
    }

    func testBitfieldExtract() {
        XCTAssertEqual(bitfieldExtract(UInt32(0xFF00_FFFF), 32, 12), 0)
        XCTAssertEqual(bitfieldExtract(UInt32(0b11100011), 1, 6), 0b110001)
    }

    func testBitfieldInsert() {
        XCTAssertEqual(bitfieldInsert(UInt32(1), 0xFF00_FF00, 8, 20), 0x0F00_FF01)
    }

    func testBitfieldReverse() {
        let u = UInt32(0xF300_00F3)
        XCTAssertEqual(bitfieldReverse(u), 0xCF00_00CF)
    }

    func testBitCount() {
        let v = ivec2(0b01010101, 0)
        XCTAssertEqual(bitCount(v), ivec2(4, 0))
    }

    func testFindLSB() {
        XCTAssertEqual(findLSB(UInt32(0)), -1)
        let v = uvec2(0b0101000, 0x8000_0000)
        XCTAssertEqual(findLSB(v), ivec2(3, 31))
    }

    func testFindMSB() {
        XCTAssertEqual(findMSB(Int32.zero), -1)
        XCTAssertEqual(findMSB(ivec3(-1, -2, 0x7FFFFFFF)), ivec3(-1, 0, 30))
    }
}
