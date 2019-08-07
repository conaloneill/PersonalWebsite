import Routing
import Vapor
import Leaf
import MailCore

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)

// MARK: Structs
struct MainView: Codable {
    var title: String?
    var body: String?
}
struct ProjectView: Codable {
    var name: String?
    var description: String?
    var photo: String?
    var allProjects: [String]
}

struct ContactForm: Codable {
    var name: String?
    var email: String?
    var message: String?
    var error: String?
}


// MARK: Global variables
let projects = [
    "monopoly": "Desktop app Monopoly game built in Java.",
    "monopolyBot": "Desktop app Monopoly game bot built in Java.",
    "panopoly": "Variation on Monopoly running on AWS with android and desktop app components.",
    "website": "My personal website is built on Vapor 3, written in Swift and hosted on Heroku.",
    "fyp" : "My Final Year Project. An iOS app swift to collect and validate handwritten letters for online character recognition"
]


//MARK: Routes
public func routes(_ router: Router) throws {
    
    let personalWebsiteController = PersonalWebsiteController()
    router.get("/", use: personalWebsiteController.home)
    router.get("cv", use: personalWebsiteController.cv)
    router.get("contact", use: personalWebsiteController.contact)
    
    
    let bitcoinAppController = BitcoinAppController()
    router.get("bitcoinapp/price", use: bitcoinAppController.bitcoinPrice)
    
    
    router.get("project", String.parameter) { req -> Future<View> in
        let projectName = try req.parameters.next(String.self)
        
        let context: ProjectView
        if let project = projects[projectName] {
            context = ProjectView(name: projectName, description: project, photo: String(describing: projectName), allProjects: projects.keys.sorted())
        } else {
            context = ProjectView(name: nil, description: nil, photo: nil, allProjects: projects.keys.sorted())
        }
        
        return try req.view().render("project", context)
    }
    
    router.get("project") { req -> Future<View> in
        let context = ProjectView(name: projects.keys.first, description: projects.values.first, photo: String(describing: projects.keys.first), allProjects: projects.keys.sorted())
        return try req.view().render("project", context)
    }
    
    router.post("submit") { req -> Future<View> in
        return try req.content.decode(ContactForm.self).flatMap(to: View.self) { form in
            guard form.name != nil else {
                return try req.view().render("submit", ContactForm(name: nil, email: nil, message: nil, error: "Failed submit, please try again!"))
            }
            
            let mail = Mailer.Message(from: String(describing: form.email!), to: "conaloneillcs@gmail.com", subject: "Email from Personal Website", text: String(describing: form.message!), html: "<p>\(String(describing: form.message!))</p>")
            return try req.mail.send(mail).flatMap(to: View.self) { mailResult in
                return try req.view().render("submit", ContactForm(name: form.name, email: form.email, message: form.message, error: nil))
            }
        }
    }
}
