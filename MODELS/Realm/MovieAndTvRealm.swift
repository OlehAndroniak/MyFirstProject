//


import Foundation
import RealmSwift

class MovieAndTvRealm: Object {
    @objc dynamic var title = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var overview = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var backdropPath = ""
    @objc dynamic var mediaType = ""
    @objc dynamic var posterPath = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
