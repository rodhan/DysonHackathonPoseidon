import XCTest

class DysonBotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    func testDysonBotConnects() {
        let bot: Bot = DysonBot(ipAddress: "192.168.1.103")

        let asyncExpectation = expectation(description: "")

        bot.move(left: 3000, right: 3000)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            bot.move(left: 0, right: 0)
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 10) {
            error in
        }
    }
}
