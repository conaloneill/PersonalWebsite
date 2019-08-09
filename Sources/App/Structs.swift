//
//  Structs.swift
//  App
//
//  Created by Conal O'Neill on 09/08/2019.
//

import Foundation

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
