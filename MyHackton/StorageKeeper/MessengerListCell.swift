import UIKit

class MessengerListCell: UITableViewCell {

    @IBOutlet var deliveryName: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var abortDeliveryButton: UIButton!
    
    var index: Int!
    var controller: MessengersListController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }

    @IBAction func toBasket(_ sender: Any) {
        let suppliesPage = controller.storyboard!.instantiateViewController(withIdentifier: "check_products") as! DonationsBasketController
        suppliesPage.manager = true
        suppliesPage.request = controller.requests[index]
        controller.navigationController?.pushViewController(suppliesPage, animated: true)
        //controller.present(suppliesPage, animated: true, completion: nil)
    }
    
    @IBAction func abortDealivery(_ sender: UIButton) {
        //by clicking the button - and pressing confirm in the alert, the product and address will be removed from the messsanger list(in the server), and the deliveries page will open
        let alert = UIAlertController(title: "ביטול בקשה", message: "האם אתה בטוח בביטול הבקשה?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "אישור", style: .default, handler: { ok in
            let prefs = UserDefaults.standard
            if let token = prefs.string(forKey: "token"){
                ServerConnections.getDoubleArrayAsync("/request_status_change", [token, "בוטל", self.controller.requests[self.index!][0] + ""], handler: {requests in
                    self.controller.viewDidAppear(false)
                })
            }
        }))
        controller.present(alert, animated: true, completion: nil)
    }
}
