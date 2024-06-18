import Fluent
import Vapor
import AsyncHTTPClient

func routes(_ app: Application) throws {
  app.get { req async in
    "Recursion in Action!"
  }

  app.get("hello") { req async -> String in
    "Hello, world!"
  }

  app.get("home") { req async throws -> Response in
    let path: String = app.directory.publicDirectory + "Templates/Bundle/index.html"
    return req.fileio.streamFile(at: path)
  }

  try app.register(collection: TodoController())
}
