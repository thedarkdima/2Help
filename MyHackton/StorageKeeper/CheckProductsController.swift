import UIKit

class CheckProductsController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    //table view functions//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "check_products") as! ProductsTableViewCell
        
        return cell
    }
    ////

}
