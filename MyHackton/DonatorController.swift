import UIKit

class DonatorConroller: UIViewController, UITableViewDataSource {
    
    //Table and textfield outlets
    @IBOutlet var tbl_products: UITableView!
    @IBOutlet var tf_money: UITextField!
    
    //example for table
    var str : [Int] = [1,2,3,4,5,6,7,8,9,10]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Products table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
      
        cell.textLabel?.text =
            "\(str[indexPath.row])"
        
        return cell
    }
    

}

