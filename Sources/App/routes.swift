import Vapor
import Leaf


/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)


//MARK: Routes
public func routes(_ app: Application) throws {
    
//    app.get { req in
//        return "Hello World!"
//    }
    
    let personalWebsiteController = PersonalWebsiteController()
    app.get("", use: personalWebsiteController.home)
    app.get("cv", use: personalWebsiteController.cv)
    app.get("contact", use: personalWebsiteController.contact)
    app.post("submit", use: personalWebsiteController.submit)
    app.get("project", use: personalWebsiteController.projectHome)
    app.get("project", ":projectID", use: personalWebsiteController.individualProject)
    
    
//    let bitcoinAppController = BitcoinAppController()
//    app.get("bitcoinapp/price", use: bitcoinAppController.bitcoinPrice)
//    app.get("bitcoinapp/currencies", use: bitcoinAppController.bitcoinCurrencies)
}
