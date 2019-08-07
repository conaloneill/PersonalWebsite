//
//  PersonalWebsiteController.swift
//  App
//
//  Created by Conal O'Neill on 31/07/2019.
//

import Foundation
import Vapor

final class PersonalWebsiteController {
    
    func home(_ req: Request) throws -> Future<View> {
        let context = MainView(title: "Welcome to my personal website!", body: projects["website"])
//        var canaryToken = try externalRequest(req: req, url: "http://canarytokens.com/traffic/static/enugbm1kmptab01tngo2zk7nw/contact.php")
        
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
}
