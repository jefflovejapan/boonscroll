import Fluent
import Vapor

struct LinkDTO: Content {
    var id: UUID?
    var url: URL
    var title: String
    var thumbnailURL: URL?
    var notes: String?
    
    func toModel() -> Link {
        let model = Link()
        model.id = self.id
        model.url = self.url
        model.title = self.title
        model.thumbnailURL = self.thumbnailURL
        model.notes = self.notes
        return model
    }
}
