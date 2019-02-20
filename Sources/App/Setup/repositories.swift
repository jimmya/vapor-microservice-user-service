import Vapor

public func setupRepositories(services: inout Services, config: inout Config) {
    services.register(PostgreUserRepository.self)
    services.register(PostgreUserSessionRepository.self)
}
