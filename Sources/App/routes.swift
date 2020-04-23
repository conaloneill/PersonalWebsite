import Vapor
import Leaf


/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)


//MARK: Routes
public func routes(_ app: Application) throws {
    
    ///BLnH-v0FUbrEH8ZGqVzr1PyS7xHPxxCHSjXQSi2uFnQ.byjwGXWbeF1CLL1lSUZLXNVeqg5NOjgxSAC01Feiry8
    ///And make it available on your web server at this URL:
    ///http://www.conaloneill.dev/.well-known/acme-challenge/BLnH-v0FUbrEH8ZGqVzr1PyS7xHPxxCHSjXQSi2uFnQ
    
    app.get(".well-known","acme-challenge","BLnH-v0FUbrEH8ZGqVzr1PyS7xHPxxCHSjXQSi2uFnQ") { req in
        return ("BLnH-v0FUbrEH8ZGqVzr1PyS7xHPxxCHSjXQSi2uFnQ.byjwGXWbeF1CLL1lSUZLXNVeqg5NOjgxSAC01Feiry8")
    }
    
    ///vAys5YpUZbtLbKj9UUV_29oHDujmaD4wqfo64JXyuWM.byjwGXWbeF1CLL1lSUZLXNVeqg5NOjgxSAC01Feiry8
    ///And make it available on your web server at this URL:
    ///http://conaloneill.dev/.well-known/acme-challenge/vAys5YpUZbtLbKj9UUV_29oHDujmaD4wqfo64JXyuWM
    app.get(".well-known","acme-challenge","vAys5YpUZbtLbKj9UUV_29oHDujmaD4wqfo64JXyuWM") { req in
        return ("vAys5YpUZbtLbKj9UUV_29oHDujmaD4wqfo64JXyuWM.byjwGXWbeF1CLL1lSUZLXNVeqg5NOjgxSAC01Feiry8")
    }
    
    
    let personalWebsiteController = PersonalWebsiteController()
    app.get("", use: personalWebsiteController.home)
    app.get("cv", use: personalWebsiteController.cv)
    app.get("contact", use: personalWebsiteController.contact)
    app.post("submit", use: personalWebsiteController.submit)
    app.get("project", use: personalWebsiteController.projectHome)
    app.get("project", ":projectID", use: personalWebsiteController.individualProject)
    
    
    let bitcoinAppController = BitcoinAppController()
    app.get("bitcoinapp", "price", use: bitcoinAppController.bitcoinPrice)
    app.get("bitcoinapp" , "currencies", use: bitcoinAppController.bitcoinCurrencies)
}
