import Fluent
import struct Foundation.UUID
import struct Foundation.URL

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class Link: Model, @unchecked Sendable {
    static let schema = "links"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "url")
    var url: URL

    @Field(key: "title")
    var title: String

    @Field(key: "thumbnailURL")
    var thumbnailURL: URL?

    @Field(key: "notes")
    var notes: String?

    init() { }

    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
    
    func toDTO() -> LinkDTO {
        .init(
            id: self.id,
            title: self.$title.value
        )
    }
}
