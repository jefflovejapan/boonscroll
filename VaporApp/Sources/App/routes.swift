import Fluent
import Vapor

func routes(_ app: Application) throws {
  app.get { req async in
    "Recursion in Action!"
  }

  app.get("hello") { req async -> String in
    "Hello, world!"
  }

//   app.get("home") { req async -> String in
//     let fileIO = req.application.fileio
//     let path = req.application.directory.publicDirectory + "index.html"

//     return fileIO.openFile(path: path, mode: .read, eventLoop: req.eventLoop).flatMap {
//       (handle, region) in
//       let response = Response(status: .ok, headers: ["Content-Type": "text/html; charset=utf-8"])
//       return fileIO.read(fileRegion: region, allocator: .init(), eventLoop: req.eventLoop).map {
//         buffer in
//         response.body = .init(buffer: buffer)
//         try? handle.close()
//         return response
//       }
//     }
//   }

  try app.register(collection: TodoController())
}
