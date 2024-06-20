import Fluent

import struct Foundation.URL
import struct Foundation.UUID
import struct Foundation.Date

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class Link: Model, @unchecked Sendable {
  static let schema = "links"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "created_at")
  var createdAt: Date

  @Field(key: "url")
  var url: URL

  @Field(key: "title")
  var title: String

  @Field(key: "thumbnail_url")
  var thumbnailURL: URL?

  @Field(key: "notes")
  var notes: String?

  init() {}

  init(id: UUID? = nil, createdAt: Date, url: URL, title: String, thumbnailURL: URL? = nil, notes: String? = nil) {
    self.id = id
    self.createdAt = createdAt
    self.url = url
    self.title = title
    self.thumbnailURL = thumbnailURL
    self.notes = notes
  }

  func toDTO() -> LinkDTO {
    .init(
      id: self.id, createdAt: self.createdAt, url: self.url, title: self.title, thumbnailURL: self.thumbnailURL,
      notes: self.notes)
  }
}
