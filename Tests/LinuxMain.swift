import XCTest
@testable import GLMathTests

extension ApproxEquatableTests {
    static let allTests: [(String, (ApproxEquatableTests) -> () throws -> ())] = [
        ("testIsClsoeTo", testIsClsoeTo),
        ("testOperator", testOperator),
        ("testApprxEqVector", testApprxEqVector),
    ]
}

extension BooleanTests {
    static let allTests: [(String, (BooleanTests) -> () throws -> ())] = [
        ("testInit", testInit),
        ("testAll", testAll),
        ("testNot", testNot),
        ("testAny", testAny),
    ]
}

extension CastTests {
    static let allTests: [(String, (CastTests) -> () throws -> ())] = [
        ("testBoolVector2NumericVector", testBoolVector2NumericVector),
        ("testNumericVector2BoolVector", testNumericVector2BoolVector),
    ]
}

extension CommonTests {
    static let allTests: [(String, (CommonTests) -> () throws -> ())] = [
        ("testAbs", testAbs),
        ("testSign", testSign),
        ("testFloor", testFloor),
        ("testTrunc", testTrunc),
        ("testRound", testRound),
        ("testRoundEven", testRoundEven),
        ("testCeil", testCeil),
        ("testFract", testFract),
        ("testMod", testMod),
        ("testModVS", testModVS),
        ("testModf", testModf),
        ("testMin", testMin),
        ("testMinVS", testMinVS),
        ("testMax", testMax),
        ("testMaxVS", testMaxVS),
        ("testClamp", testClamp),
        ("testClampVV", testClampVV),
        ("testClamVS", testClamVS),
        ("testMix", testMix),
        ("testMixVS", testMixVS),
        ("testMixVB", testMixVB),
        ("testStep", testStep),
        ("testStepVS", testStepVS),
        ("testSmoothstep", testSmoothstep),
        ("testSmoothstepVS", testSmoothstepVS),
        ("testIsNaN", testIsNaN),
        ("testIsInf", testIsInf),
        ("testFloatBitsToInt", testFloatBitsToInt),
        ("testFloatBitsToUint", testFloatBitsToUint),
        ("testIntBitsToFloat", testIntBitsToFloat),
        ("testUIntBitsToFloat", testUIntBitsToFloat),
        ("testFma", testFma),
        ("testFrexp", testFrexp),
        ("testLdexp", testLdexp),
    ]
}

XCTMain([
    testCase(ApproxEquatableTests.allTests),
    testCase(BooleanTests.allTests),
    testCase(CastTests.allTests),
    testCase(CommonTests.allTests),
])
