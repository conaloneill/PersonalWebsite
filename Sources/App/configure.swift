import Vapor
import Leaf

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(_ app: Application) throws {
    
    //configure custom port number
    app.http.server.configuration.port = 8080
    // Configure custom hostname.
    app.http.server.configuration.hostname = "localhost"
    
     // uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    
    app.views.use(.leaf)
    
    
    // SendGrid
    app.sendgrid.initialize()
    
    
    try routes(app)
}
