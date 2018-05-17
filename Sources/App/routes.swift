import Routing
import Vapor
import Leaf

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)

struct MainView: Codable {
	var title: String?
	var body: String?
}
public func routes(_ router: Router) throws {
    router.get("/") { req -> Future<View> in
		
		let context = MainView(title: "Welcome to my personal website!", body: "This website is running on Vapor 3.0.2 and hosted on GitHub Pages.")
        return try req.view().render("home", context)
    }
	
	
	router.get("project", String.parameter) { req -> Future<View> in
		let projectName = try req.parameters.next(String.self)

		
		let projects = [
			"monopoly": "Desktop app Monopoly game built in Java",
			"monopolyBot": "Desktop app Monopoly game bot built in Java",
			"website": "Personal website built on Vapor 3.0.2 written in Swift"
		]
		struct ProjectView: Codable {
			var name: String?
			var description: String?
			var photo: String?
			var allProjects: [String]?
		}
		
		let context: ProjectView
		
		if let projectDescription = projects[projectName] {
			context = ProjectView(name: projectName, description: projectDescription, photo: nil, allProjects: projects.keys.sorted())
		} else {
			context = ProjectView(name: nil, description: nil, photo: nil, allProjects: projects.keys.sorted())
		}
		
		return try req.view().render("project", context)
	}
	
	
	router.get("contact") { req -> Future<View> in
		let context = MainView(title: "Contact Me", body: "conaloneillcs@gmail.com")
		
		return try req.view().render("contact", context)
	}
	
	
}
