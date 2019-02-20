import Vapor

protocol MailClient: Service {
    func send(email: String, subject: String, text: String, html: String?, on container: Container) throws -> Future<HTTPStatus>
}

final class RemoteMailClient: MailClient {
    
    private let host: String
    
    init(host: String) {
        self.host = host
    }
    
    func send(email: String, subject: String, text: String, html: String?, on container: Container) throws -> EventLoopFuture<HTTPStatus> {
        let url = host + "/mail"
        let request = SendMailRequest(email: email, subject: subject, text: text, html: html)
        return try container.client().post(url) { req in
            try req.content.encode(request)
            }.map { response in
                if response.http.status == .ok {
                    return .ok
                } else {
                    throw Abort(response.http.status)
                }
        }
    }
}
