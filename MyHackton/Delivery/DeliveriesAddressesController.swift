import UIKit

class DeliveriesAddressesController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
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
        let cell = tableView.cellForRow(at: indexPath) as! DeliveriesAddressesCell
        let next = storyboard!.instantiateViewController(withIdentifier: "statusPage") as! DonatorsStatusController
        next.set(address: cell.address.text!)
        show(next, sender: self)
    }
    

}
