import XCTest
@testable import GLMathTests

extension VectorTests {
    static let allTests: [(String, (VectorTests) -> () throws -> ())] = [
    ]
}

XCTMain([
     testCase(VectorTests.allTests),
])
