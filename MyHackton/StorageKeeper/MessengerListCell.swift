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
    
}
