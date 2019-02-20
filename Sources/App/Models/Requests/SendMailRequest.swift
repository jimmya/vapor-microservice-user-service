import Vapor

struct SendMailRequest: Content {
    
    let email: String
    let subject: String
    let text: String
    let html: String?
    
    init(email: String, subject: String, text: String, html: String?) {
        self.email = email
        self.subject = subject
        self.text = text
        self.html = html
    }
}
