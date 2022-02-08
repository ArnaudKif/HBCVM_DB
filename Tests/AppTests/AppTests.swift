@testable import App
import XCTVapor
import Foundation

final class AppTests: XCTestCase {
    func testHelloWorld() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        try app.test(.GET, "hello", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hello, world!")
        })
    }

    func testItsWork() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        try app.test(.GET, "", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "It works!")
        })
    }

    func testGetMatches() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        try app.test(.GET, "matches", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }

    func testCountMatches() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        try app.test(.GET, "count", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }

}
