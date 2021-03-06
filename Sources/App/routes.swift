import Vapor


/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)


//MARK: Routes
public func routes(_ app: Application) throws {
    
    
    // ACME Challenge for Let's Encrypt SSL cert for domain
    
    ///AaKHkyiRUjmgx1__IzIxuU5QZM2BBg0_N5LzErAfjVo.byjwGXWbeF1CLL1lSUZLXNVeqg5NOjgxSAC01Feiry8
    ///And make it available on your web server at this URL:
    ///http://conaloneill.dev/.well-known/acme-challenge/AaKHkyiRUjmgx1__IzIxuU5QZM2BBg0_N5LzErAfjVo
    
    app.get(".well-known","acme-challenge","AaKHkyiRUjmgx1__IzIxuU5QZM2BBg0_N5LzErAfjVo") { req in
        return ("AaKHkyiRUjmgx1__IzIxuU5QZM2BBg0_N5LzErAfjVo.byjwGXWbeF1CLL1lSUZLXNVeqg5NOjgxSAC01Feiry8")
    }
    
    ///HOetqLWctvNbnkfval4DiE0oqBqUlP8-HGnbkMkOQxg.byjwGXWbeF1CLL1lSUZLXNVeqg5NOjgxSAC01Feiry8
    ///And make it available on your web server at this URL:
    ///http://www.conaloneill.dev/.well-known/acme-challenge/HOetqLWctvNbnkfval4DiE0oqBqUlP8-HGnbkMkOQxg
    app.get(".well-known","acme-challenge","HOetqLWctvNbnkfval4DiE0oqBqUlP8-HGnbkMkOQxg") { req in
        return ("HOetqLWctvNbnkfval4DiE0oqBqUlP8-HGnbkMkOQxg.byjwGXWbeF1CLL1lSUZLXNVeqg5NOjgxSAC01Feiry8")
    }
    
    // Redirect to projects from project
    app.get("project") { req in
        req.eventLoop.future(req.redirect(to: "projects"))
    }
    
    // Redirect to projects from project with a project key
    app.get("project", ":projectID") { req -> EventLoopFuture<Response> in
        guard let projectName = req.parameters.get("projectID") else {
            return req.eventLoop.future(req.redirect(to: "projects"))
        }
        return req.eventLoop.future(req.redirect(to: "/projects/\(projectName)"))
    }
    
    
    let personalWebsiteController = PersonalWebsiteController()
    app.get("", use: personalWebsiteController.home)
    app.get("cv", use: personalWebsiteController.cv)
    
    
    app.get("contact", use: personalWebsiteController.contact)
    app.post("submit", use: personalWebsiteController.submit)
    app.get("projects", use: personalWebsiteController.projectHome)
    app.get("projects", ":projectID", use: personalWebsiteController.individualProject)
    
    
    
    
    let bitcoinAppController = BitcoinAppController()
    app.get("bitcoinapp", "price", use: bitcoinAppController.bitcoinPrice)
    app.get("bitcoinapp" , "currencies", use: bitcoinAppController.bitcoinCurrencies)
    
    
    
    /// WebSocket
    app.webSocket("echo") { req, ws in
        print(ws)
        
        // Echoes received messages.
        ws.onText { ws, text in
            print("Received text: \(text)")
            ws.send("Test text from Vapor Server")
        }
    }
    
}
