import Vapor
import FluentPostgreSQL

protocol UserSessionRepository: ServiceType {
    func save(userSession: UserSession, on connectable: DatabaseConnectable) throws -> Future<UserSession>
}

final class PostgreUserSessionRepository: UserSessionRepository {
    
    let database: PostgreSQLDatabase.ConnectionPool
    
    init(_ database: PostgreSQLDatabase.ConnectionPool) {
        self.database = database
    }
    
    func save(userSession: UserSession, on connectable: DatabaseConnectable) throws -> Future<UserSession> {
        return userSession.save(on: connectable)
    }
}

//MARK: - ServiceType conformance
extension PostgreUserSessionRepository {
    static let serviceSupports: [Any.Type] = [UserSessionRepository.self]
    
    static func makeService(for worker: Container) throws -> Self {
        return .init(try worker.connectionPool(to: .psql))
    }
}
