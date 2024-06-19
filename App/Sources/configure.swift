import Fluent
import FluentPostgresDriver
import FluentSQLiteDriver
import NIOSSL
import SQLiteKit
import Vapor
import os

// configures your application
public func configure(_ app: Application) async throws {
  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  app.logger.info("Give me that environment: \(ProcessInfo.processInfo.environment)")
  app.logger.info("How about the app's environment? \(app.environment)")
  app.logger.logLevel = .debug
  let databaseType = Environment.get("DATABASE_TYPE")
  switch databaseType {
  case "sqlite":
    let config = SQLiteConfiguration(storage: .memory)
    app.databases.use(DatabaseConfigurationFactory.sqlite(config), as: .sqlite)
  case "postgres":
    app.databases.use(
      DatabaseConfigurationFactory.postgres(
        configuration: .init(
          hostname: Environment.get("DATABASE_HOST") ?? "localhost",
          username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
          password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
          database: Environment.get("DATABASE_NAME") ?? "vapor_database",
          tls: .prefer(try .init(configuration: .clientDefault)))
      ), as: .psql)
  default:
    throw ConfigurationError.unknownDatabaseType(databaseType)
  }

  /*
  file middleware -> index.html call some endpoint

  Put the JS and HTML etc. on a CDN and have the Swift code on a completely separate server
  */

  app.migrations.add(CreateTodo(), CreateLink())
  // register routes
  let fileMiddleware = FileMiddleware(
    publicDirectory: app.directory.publicDirectory
  )
  app.middleware.use(fileMiddleware)
  try routes(app)
}
