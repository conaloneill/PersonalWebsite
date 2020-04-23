//
//  PersonalWebsiteController.swift
//  App
//
//  Created by Conal O'Neill on 31/07/2019.
//

import Foundation
import Vapor
import SendGrid



// MARK: Global variables
let projects = [
    Project(
        key: "fyp",
        name: "Final Year Project",
        description: "My Final Year Project. An iOS app writtin in Swift. The app was used to collect and validate handwritten letters and words. The data collected was stored using CoreData and can be exported for use in online text recognition machine learning research. Below image shows a screengrab of the validation section of the app where the input is spilt by strokes"
    ),
    Project(
        key: "monopolyBot",
        name: "Monopoly Bot",
        description: "Game bot that plays a game of Monopoly. Built in Java."
    ),
    Project(
        key: "website",
        name: "Personal Wesbite",
        description: "My personal website is built on Vapor 4, written in Swift 5.2 and hosted on Heroku."
    ),
    Project(
        key: "botBoard",
        name: "BotBoard",
        description: "Java Message Board application using Netflix's Eureka for service discovery of integrated AirQuality and Bitcoin bots, with Swagger for API documentation"
    ),
    Project(
        key: "monopoly",
        name: "Monopoly",
        description: "Monopoly game that is locally played on a single desktop using typed commands to play. Built in Java."
    ),
    Project(
        key: "panopoly",
        name: "Panopoly",
        description: "Variation on Monopoly using randomly generated board spaces and characters. Server component runs on AWS with a Desktop component used to display the board. Android app is used as the game controller. All writting in Java with some Kotlin in the Android app."
    )
]




final class PersonalWebsiteController {
    
    func home(_ req: Request) throws -> EventLoopFuture<View> {
        let context = MainView(title: "Welcome to my personal website!", body: projects.filter{$0.key == "website"}.description)
        if let url = Environment.get("CANARY_URL") {
//            _ = try externalRequest(req: req, url: url)
        }
        return req.view.render("home", context)
    }
    
    
    func cv(_ req: Request) throws -> EventLoopFuture<View> {
        let context = MainView(title: "CV", body: "Education")
        return req.view.render("cv", context)
    }
    
    func contact(_ req: Request) throws -> EventLoopFuture<View> {
        let context = MainView(title: "Contact Me", body: "conaloneillcs@gmail.com")
        return req.view.render("contact", context)
    }
    
    func submit(_ req: Request) throws -> EventLoopFuture<View> {
        
        let form = try req.content.decode(ContactForm.self)
        let emailAddress = EmailAddress(email: "conaloneillcs@gmail.com", name: "CSEmail")
        let personalizations = Personalization(to: [emailAddress], subject: "Email from Personal Website")
        let content = [["type": "text/plain", "value": "Message: \(form.message!) \n\n from: \(form.name!)"]]
        
        let email = SendGridEmail(personalizations: [personalizations], from: EmailAddress(email: form.email ?? "no email given"), replyTo: EmailAddress(email: form.email ?? "no email given"), subject: "Email from Personal Website", content: content)
        
        _ = try req.application.sendgrid.client.send(email: email, on: req.eventLoop)
        return req.view.render("submit", ContactForm(name: form.name, email: form.email, message: form.message, error: nil))
    }
    
    
    func projectHome(_ req: Request) throws -> EventLoopFuture<View> {
        let context = ProjectView(
            name: projects.first?.name,
            description: projects.first?.description,
            photo: String(describing: projects.first),
            allProjects: projects
        )
        return req.view.render("project", context)
    }
    
    func individualProject(_ req: Request) throws -> EventLoopFuture<View> {
        let projectName = req.parameters.get("projectID")
        
        let context: ProjectView
        
        if let project = projects.first(where: {$0.key == projectName!}) {
            context = ProjectView(
                name: project.name,
                description: project.description,
                photo: projectName!,
                allProjects: projects
            )
        } else {
            context = ProjectView(
                name: nil,
                description: nil,
                photo: nil,
                allProjects: projects
            )
        }
        
        return req.view.render("project", context)
    }
}


//
//let context = ProjectView(
//    name: projects.keys.first,
//    description: projects.values.first?.description,
//    photo: String(describing: projects.keys.first),
//    key: projects.keys.sorted(),
//    allProjects: Array(
//        projects.values.map { project in
//            return project.name
//        }.sorted(by: {$0 < $1 })
//    )
//)
