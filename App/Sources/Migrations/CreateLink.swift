import Fluent

struct CreateLink: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("links")
            .id()
            .field("url", .string, .required)
            .field("title", .string, .required)
            .field("thumbnail_url", .string)
            .field("notes", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("links").delete()
    }
}