import XCTest
@testable import securityHeadersMiddleware

final class securityHeadersMiddlewareTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(securityHeadersMiddleware().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
