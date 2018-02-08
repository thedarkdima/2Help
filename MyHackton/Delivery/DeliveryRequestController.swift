import UIKit

class DeliveryRequestController: UIViewController, UITableViewDataSource ,UITableViewDelegate {

    private var RequestsList : [Donator] = []
    private var donator : Donator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requests_list_ofDelivery") as! DeliveryRequestCell // 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DeliveryRequestCell
        let next = storyboard?.instantiateViewController(withIdentifier: "statusPage") as! DonatorsStatusController
        
        next.set(address: cell.adress.text!)
        //RequestsList.remove(at: indexPath.row)
        show(next, sender: self)
        tabBarController?.navigationItem.backBarButtonItem?.title = "חזור"
    }
    
    func setDonatorObj(donator : Donator){
        self.donator = donator
    }

    
   
}
