import FluentPostgreSQL
import Vapor

struct User {
    
    var id: UUID?
    var username: String
    var email: String
    var password: String
    var verified: Bool

    init(id: UUID? = nil, username: String, email: String, password: String) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.verified = false
    }
}

extension User: PostgreSQLUUIDModel { }
extension User: Migration { }
