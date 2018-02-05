import UIKit

class DonatorsStatusController: UIViewController {

    @IBOutlet var donatorsAddressLbl: UILabel!
    private var address: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        donatorsAddressLbl.text = address
    }
  
    public func set(address: String){
        self.address = address
    }

}
