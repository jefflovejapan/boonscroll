import Fluent
import XCTVapor

@testable import App

final class LinkTests: XCTestCase {
  var app: Application!

  override func setUp() async throws {
    self.app = try await Application.make(.testing)
    try await configure(app)
    try await app.autoMigrate()
  }

  override func tearDown() async throws {
    try await app.autoRevert()
    try await self.app.asyncShutdown()
    self.app = nil
  }

  func testCreatingLinkAddsToDB() async throws {
    let linkInput = LinkInput(
      url: try XCTUnwrap(URL(string: "https://sears.com")),
      title: "Sears"
    )
    try await self.app.test(
      .POST, "links",
      beforeRequest: { req in
        try req.content.encode(linkInput)
      },
      afterResponse: { res async throws in
        XCTAssertEqual(res.status, .ok)
        let models: [Link] = try await Link.query(on: self.app.db).all()
        XCTAssertEqual(models.count, 1)
        XCTAssertEqual(models.map { $0.toDTO().title }, [linkInput.title])
      })
  }

  func testCreatingLinkWithBadURLThrows() async throws {
    let linkInput = LinkInput(
      url: try XCTUnwrap(URL(string: "whatever")),
      title: "Bad"
    )
    try await self.app.test(
        .POST, "links",
        beforeRequest: { req async throws in
          try req.content.encode(linkInput)
        },
        afterResponse: { (response: XCTHTTPResponse) async throws -> Void in
            XCTAssertEqual(response.status, .badRequest)
        })
  }
}
