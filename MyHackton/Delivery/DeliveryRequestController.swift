import UIKit

class DeliveryRequestController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell()
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
   
}
