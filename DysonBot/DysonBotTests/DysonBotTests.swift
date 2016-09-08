import XCTest
@testable import DysonBot
class DysonBotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    func testPayloadParse() {
        let parsedData = DysonBot.parse(jsonPayload: "{\"FrontLeft\":39,\"FrontRight\":214,\"SideLeft\":44,\"SideRight\":37}")
        XCTAssertNotNil(parsedData)
        XCTAssertEqual(parsedData!["FrontLeft"], 39)
    }

    func testDysonBotConnects() {
        let bot: Bot = DysonBot(ipAddress: "192.168.1.103")

        let asyncExpectation = expectation(description: "")

        bot.move(left: 3000, right: 3000)

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            bot.move(left: 0, right: 0)
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 5000) {
            (error) in
        }
    }
}
