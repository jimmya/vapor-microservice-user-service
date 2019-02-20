import Vapor
import FluentPostgreSQL

protocol UserRepository: ServiceType {
    func findCount(username: String, email: String, on connectable: DatabaseConnectable) throws -> Future<Int>
    func find(email: String, on connectable: DatabaseConnectable) throws -> Future<User?>
    func find(user: UUID, on connectable: DatabaseConnectable) throws -> Future<User?>
    func save(user: User, on connectable: DatabaseConnectable) throws -> Future<User>
}

final class PostgreUserRepository: UserRepository {
    
    let database: PostgreSQLDatabase.ConnectionPool
    
    init(_ database: PostgreSQLDatabase.ConnectionPool) {
        self.database = database
    }
    
    func findCount(username: String, email: String, on connectable: DatabaseConnectable) throws -> EventLoopFuture<Int> {
        return User.query(on: connectable).group(.or) {
            $0.filter(\.username == username)
            $0.filter(\.email == email)
        }.count()
    }
    
    func find(email: String, on connectable: DatabaseConnectable) throws -> EventLoopFuture<User?> {
        return User.query(on: connectable).filter(\.email == email).first()
    }
    
    func find(user: UUID, on connectable: DatabaseConnectable) throws -> EventLoopFuture<User?> {
        return User.query(on: connectable).filter(\.id == user).first()
    }
    
    func save(user: User, on connectable: DatabaseConnectable) throws -> EventLoopFuture<User> {
        return user.save(on: connectable)
    }
}

//MARK: - ServiceType conformance
extension PostgreUserRepository {
    static let serviceSupports: [Any.Type] = [UserRepository.self]
    
    static func makeService(for worker: Container) throws -> Self {
        return .init(try worker.connectionPool(to: .psql))
    }
}

extension Database {
    public typealias ConnectionPool = DatabaseConnectionPool<ConfiguredDatabase<Self>>
}
