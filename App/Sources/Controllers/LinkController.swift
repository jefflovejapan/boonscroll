import Fluent
import Vapor

struct LinkInput: Content {
    var url: URL
    var title: String
    var thumbnailURL: URL?

    func toModel() -> Link {
        return Link.init(id: nil, url: self.url, title: self.title, thumbnailURL: nil, notes: nil)
    }
}

struct LinkController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("links")

        todos.get(use: self.index)
        todos.post(use: self.create)
    }

    @Sendable
    func index(req: Request) async throws -> [LinkDTO] {
        try await Link.query(on: req.db).all().map { $0.toDTO() }
    }

    @Sendable
    func create(req: Request) async throws -> LinkDTO {
        let link = try req.content.decode(LinkInput.self).toModel()

        try await link.save(on: req.db)
        return link.toDTO()
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let link = try await Link.find(req.parameters.get("todoID"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await link.delete(on: req.db)
        return .noContent
    }
}
