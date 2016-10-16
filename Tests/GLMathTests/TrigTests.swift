
import XCTest
import simd
@testable import GLMath

class TrigTests: XCTestCase {

    func testRadians() {
        let pi_2 = Float.half_pi
        XCTAssertEqualWithAccuracy(radians(degrees(pi_2)), pi_2, accuracy: Float.epsilon)
        XCTAssertEqualWithAccuracy(radians(vec3(90)).z, Float.half_pi, accuracy: Float.epsilon)
    }

    func testDegrees() {
        XCTAssertEqualWithAccuracy(degrees(dvec4.one_third_pi).w, 60, accuracy: 1e-10)
    }
}
