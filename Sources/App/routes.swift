import Routing
import Vapor
import Leaf
import MailCore

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)


//MARK: Routes
public func routes(_ router: Router) throws {
    
    let personalWebsiteController = PersonalWebsiteController()
    router.get("/", use: personalWebsiteController.home)
    router.get("cv", use: personalWebsiteController.cv)
    router.get("contact", use: personalWebsiteController.contact)
    router.post("submit", use: personalWebsiteController.submit)
    router.get("project", use: personalWebsiteController.projectHome)
    router.get("project", String.parameter, use: personalWebsiteController.individualProject)
    
    
    let bitcoinAppController = BitcoinAppController()
    router.get("bitcoinapp/price", use: bitcoinAppController.bitcoinPrice)
    router.get("bitcoinapp/currencies", use: bitcoinAppController.bitcoinCurrencies)
}
