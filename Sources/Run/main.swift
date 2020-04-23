//import App
//import Service
//import Vapor
//import Foundation
//
//// The contents of main are wrapped in a do/catch block because any errors that get raised to the top level will crash Xcode
//do {
//    var config = Config.default()
//    var env = try Environment.detect()
//    var services = Services.default()
//
//	var serverConfig: NIOServerConfig
//
//	if let portString = ProcessInfo.processInfo.environment["PORT"],
//		let port = UInt16(portString) {
//		serverConfig = NIOServerConfig.default(hostname: "0.0.0.0", port: Int(port))
//		services.register { container in
//			return serverConfig
//		}
//	}
//
//    try App.configure(&config, &env, &services)
//
//    let app = try Application(
//        config: config,
//        environment: env,
//        services: services
//    )
//
//    try App.boot(app)
//
//    try app.run()
//} catch {
//    print(error)
//    exit(1)
//}



import App
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try configure(app)
try app.run()
