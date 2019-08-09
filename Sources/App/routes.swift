import Routing
import Vapor
import Leaf
import MailCore

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)




// MARK: Global variables
let projects = [
    "monopoly": "Desktop app Monopoly game built in Java.",
    "monopolyBot": "Desktop app Monopoly game bot built in Java.",
    "panopoly": "Variation on Monopoly running on AWS with android and desktop app components.",
    "website": "My personal website is built on Vapor 3, written in Swift and hosted on Heroku.",
    "fyp" : "My Final Year Project. An iOS app swift to collect and validate handwritten letters for online character recognition"
]


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
    
}
