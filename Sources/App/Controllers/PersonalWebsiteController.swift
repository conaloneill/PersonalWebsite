//
//  PersonalWebsiteController.swift
//  App
//
//  Created by Conal O'Neill on 31/07/2019.
//

import Foundation
import Vapor
import MailCore



// MARK: Global variables
let projects = [
    "monopoly": "Monopoly game that is locally played on a single desktop using typed commands to play. Built in Java.",
    "monopolyBot": "Game bot that plays a game of Monopoly. Built in Java.",
    "panopoly": "Variation on Monopoly using randomly generated board spaces and characters. Server component runs on AWS with a Desktop component used to display the board. Android app is used as the game controller. All writting in Java with some Kotlin in the Android app.",
    "website": "My personal website is built on Vapor 3, written in Swift 5 and hosted on Heroku.",
    "botBoard": "Java Message Board application using Netflix's Eureka for service discovery of integrated AirQuality and Bitcoin bots, with Swagger for API documentation",
    "fyp" : "My Final Year Project. An iOS app writtin in Swift. The app was used to collect and validate handwritten letters and words. The data collected was stored using CoreData and can be exported for use in online text recognition machine learning research. Below image shows a screengrab of the validation section of the app where the input is spilt by strokes"
]




final class PersonalWebsiteController {
    
    func home(_ req: Request) throws -> Future<View> {
        let context = MainView(title: "Welcome to my personal website!", body: projects["website"])
        if let url = Environment.get("CANARY_URL") {
            _ = try externalRequest(req: req, url: url)
        }
        return try req.view().render("home", context)
    }
    
    
    func cv(_ req: Request) throws -> Future<View> {
        let context = MainView(title: "CV", body: "Education")
        return try req.view().render("cv", context)
    }
    
    func contact(_ req: Request) throws -> Future<View> {
        let context = MainView(title: "Contact Me", body: "conaloneillcs@gmail.com")
        return try req.view().render("contact", context)
    }
    
    func submit(_ req: Request) throws -> Future<View> {
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
    
    
    func projectHome(_ req: Request) throws -> Future<View> {
        let context = ProjectView(name: projects.keys.first, description: projects.values.first, photo: String(describing: projects.keys.first), allProjects: projects.keys.sorted())
        return try req.view().render("project", context)
    }
    
    func individualProject(_ req: Request) throws -> Future<View> {
        let projectName = try req.parameters.next(String.self)
        
        let context: ProjectView
        if let project = projects[projectName] {
            context = ProjectView(name: projectName, description: project, photo: String(describing: projectName), allProjects: projects.keys.sorted())
        } else {
            context = ProjectView(name: nil, description: nil, photo: nil, allProjects: projects.keys.sorted())
        }
        
        return try req.view().render("project", context)
    }
}
