import XCTest
import PhonePePayment

final class PhonePePaymentTests: XCTestCase {
    func testSDK() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let ppPayment = PPPayment(environment: .sandbox, enableLogging: true, appId: "")
        XCTAssertNotNil(ppPayment, "PhonePe Payment SDK should not be nil")
    }
}
