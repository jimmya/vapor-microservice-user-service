import FluentPostgreSQL
import Vapor

struct UserSession {
    
    var id: UUID?
    var userId: User.ID
    var uuid: UUID
    var expires: Date
    
    init(id: UUID? = nil, userId: User.ID, uuid: UUID, expires: Date) {
        self.id = id
        self.userId = userId
        self.uuid = uuid
        self.expires = expires
    }
}

extension UserSession: PostgreSQLUUIDModel { }
extension UserSession: Migration { }
