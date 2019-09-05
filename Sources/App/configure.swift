import Vapor
import Leaf
import MailCore

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
    ) throws {
    services.register { _ in
        NIOServerConfig.default(hostname: "0.0.0.0", port: 8080)
    }
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Configure the rest of your application here
    
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    var middleware = MiddlewareConfig.default()
    services.register(StreamableFileMiddleware.self)
    middleware.use(StreamableFileMiddleware.self)
    services.register(middleware)
    
    
    services.register { container -> LeafTagConfig in
        var config = LeafTagConfig.default()
        config.use(Raw(), as: "raw")   // #raw(<myVar>) to print it as raw html in leaf vars
        return config
    }
    
    
    // mail core config - SendGrid
    let configMailCore = Mailer.Config.sendGrid(key: Environment.get("SENDGRID_API_KEY") ?? "")
    try Mailer(config: configMailCore, registerOn: &services)
}
