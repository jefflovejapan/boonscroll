import Fluent
import Vapor

struct LinkInput: Content, Validatable {
  var url: URL
  var title: String
  var thumbnailURL: URL?

  func toModel() -> Link {
    return Link.init(id: nil, url: self.url, title: self.title, thumbnailURL: nil, notes: nil)
  }

  static func validations(_ validations: inout Validations) {
    validations.add("url", as: String.self, is: .url)
  }
}

struct LinkController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let links = routes.grouped("links")

    links.get(use: self.index)
    links.post(use: self.create)
    links.delete(":link_id", use: self.delete)
  }

  @Sendable
  func index(req: Request) async throws -> [LinkDTO] {
    do {
      let result = try await Link.query(on: req.db).all().map { $0.toDTO() }
      return result
    } catch {
      throw (error)
    }
  }

  @Sendable
  func create(req: Request) async throws -> LinkDTO {
    do {
      try LinkInput.validate(content: req)
      let link = try req.content.decode(LinkInput.self).toModel()
      try await link.save(on: req.db)
      return link.toDTO()
    } catch {
      throw error
    }
  }

  @Sendable
  func delete(req: Request) async throws -> HTTPStatus {
    guard let linkID = req.parameters.get("link_id", as: UUID.self) else {
      throw Abort(.badRequest)
    }
    guard let link = try await Link.find(linkID, on: req.db) else {
      throw Abort(.notFound)
    }

    try await link.delete(on: req.db)
    return .noContent
  }
}
