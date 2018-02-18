import UIKit

class DonatorAddressCell: UITableViewCell {
    
    
    var donatordirectController : DonatorDirectionsController!
    
    @IBOutlet var address_name: UILabel!
    public var index: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func toAlert() {
        donatordirectController.i = self.index
        let alert = donatordirectController.storyboard!.instantiateViewController(withIdentifier: "alert") as! AlertController
        alert.set(name: donatordirectController.locations[index][0], phone: donatordirectController.locations[index][1], address: donatordirectController.locations[index][2], openHours: donatordirectController.locations[index][3])
        
    }
    
    
    func set(donatordirectController : DonatorDirectionsController) {
        self.donatordirectController = donatordirectController
    }

        
    
}
