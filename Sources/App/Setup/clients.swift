import Vapor

public func setupClients(services: inout Services, config: inout Config) throws {
    guard let mailHost: String = Environment.get("MAIL_HOST") else {
        throw Abort(.internalServerError, reason: "No mail service host provided")
    }
    services.register(MailClient.self) { _ -> RemoteMailClient in
        return RemoteMailClient(host: mailHost)
    }
}
