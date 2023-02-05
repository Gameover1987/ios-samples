
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        title = "title-localizable"§
        
        let localizedStr = NSLocalizedString("preved", tableName: "CustomLocalizationTable", bundle: Bundle.main, value: "", comment: "")
        print(localizedStr)
        
        let formatted = NSLocalizedString("DogEatingVegetables", comment: "")
        let localized1 = String(format: formatted, "Tor", 1, 3)
        let localized2 = String(format: formatted, "Tor", 1, 4)
        let localized3 = String(format: formatted, "Tor", 1, 5)
        let localized4 = String(format: formatted, "Tor", 1, 21)
        
        print(localized1)
        print(localized2)
        print(localized3)
        print(localized4)
    }


}

