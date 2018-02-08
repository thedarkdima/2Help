import UIKit

class DeliveriesAddressesController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    private var myDeliveryList : [Donator] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waiting_adress") as! DeliveriesAddressesCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DeliveriesAddressesCell // access all cell properties
        let next = storyboard!.instantiateViewController(withIdentifier: "statusPage") as! DonatorsStatusController // access all status properties
        
        next.set(address: cell.address.text!) // use the DonatorStatusController method - sending the cell address to change the address in status
        
        show(next, sender: self) //move to DonatorStatusController
    }
    

}
