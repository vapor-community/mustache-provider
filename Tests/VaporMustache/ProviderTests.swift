import XCTest
@testable import VaporMustache
import Vapor

class ProviderTests: XCTestCase {
    static let allTests = [
        ("testSaveAndFind", testSaveAndFind)
    ]

    func testSaveAndFind() {
        let provider = Provider(withIncludes: [
            "a": "Includes/test-include-a.mustache",
            "b": "Includes/test-include-b.mustache",
        ])

        let app = Application(providers: [provider])

        let name = "abcdefghijklmnopqrstuvwxyz1234567890!@#$%^*()"

        do {
            let view = try app.view("test-view.mustache", context: ["name": name])

            let response = view.makeResponse(for: try Request(method: .get, path: "/"))

            switch response.body {
            case .data(let bytes):
                let encoded = String(name.characters.split(separator: "&").joined(separator: "&amp;".characters))
                let expected = "a\n\nHello, \(encoded)\n\nb"

                let string = try bytes.toString()
                XCTAssertEqual(string, expected, "Template did not render properly")
            case .chunked(_):
                XCTFail("Incorrect body type")
            }
        } catch {
            XCTFail("Could not make view: \(error)")
        }
    }
}
