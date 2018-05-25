import Routing
import Vapor
import Leaf
import SendGrid
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
	"monopoly": "Desktop app Monopoly game built in Java",
	"monopolyBot": "Desktop app Monopoly game bot built in Java",
	"panopoly": "variation on Monopoly running on AWS with android and desktop app components",
	"website": "Personal website built on Vapor 3.0.2, written in Swift and hosted on Heroku"
]


//MARK: Routes
public func routes(_ router: Router) throws {
    router.get("/") { req -> Future<View> in
		
		let context = MainView(title: "Welcome to my personal website!", body: "This website is running on Vapor 3.0.2 and hosted on Heroku.")
        return try req.view().render("home", context)
    }
	
	
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
		let context = ProjectView(name: nil, description: nil, photo: nil, allProjects: projects.keys.sorted())
		return try req.view().render("project", context)
	}
	
	
	router.get("contact") { req -> Future<View> in
		let context = MainView(title: "Contact Me", body: "conaloneillcs@gmail.com")
		
		return try req.view().render("contact", context)
	}
	
	router.post("submit") { req -> Future<View> in
		return try req.content.decode(ContactForm.self).flatMap(to: View.self) { form in
			print(form.name ?? "No name given")
			print(form.email ?? "No email given")
			print(form.message ?? "No message given")
			guard form.name != nil else {
				return try req.view().render("submit", ContactForm(name: nil, email: nil, message: nil, error: "Failed submit, please try again!"))
			}
			
			let mail = Mailer.Message(from: String(describing: form.email!), to: "conaloneillcs@gmail.com", subject: "Email from Personal Website", text: String(describing: form.message!), html: "<p>\(String(describing: form.message!))</p>")
			
			print(mail)
			return try req.mail.send(mail).flatMap(to: View.self) { mailResult in
				print(mailResult)
				// ... Return your response for example
				return try req.view().render("submit", ContactForm(name: form.name, email: form.email, message: form.message, error: nil))
			}
		}
	}
}
