import UIKit

class MessengerListCell: UITableViewCell {

    @IBOutlet var deliveryName: UILabel!
    @IBOutlet var address: UILabel!
    var index: Int!
    var controller: MessengersListController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func toBasket(_ sender: Any) {
        let suppliesPage = controller.storyboard!.instantiateViewController(withIdentifier: "check_products") as! DonationsBasketController
        suppliesPage.manager = true
        suppliesPage.request = controller.requests[index]
        controller.navigationController?.pushViewController(suppliesPage, animated: true)
        //controller.present(suppliesPage, animated: true, completion: nil)
    }
    
    @IBAction func abortDealivery(_ sender: UIButton) {
        let prefs = UserDefaults.standard
        if let token = prefs.string(forKey: "token"){
            ServerConnections.getDoubleArrayAsync("/request_status_change", [token, "בוטל", controller.requests[index!][0] + ""], handler: {requests in
                self.controller.requestsList.reloadData()
            })
        }
    }
}
