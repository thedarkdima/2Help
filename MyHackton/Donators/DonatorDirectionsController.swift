import UIKit

class DonatorDirectionsController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var table: UITableView!
    
    var directionsList: [String] = []
    
    var selectedIndex: Int!
    var package: String!
    var locations : [[String]]!
    
    override func viewWillAppear(_ animated: Bool) {
                tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = false
                tabBarController!.navigationItem.rightBarButtonItem!.title = ""
        
                tabBarController!.navigationItem.backBarButtonItem!.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
            tabBarController!.title = tabBarItem!.title
            package = "warehouse"
        
        directionsList = []
        
        ServerConnections.getDoubleArrayAsync("/locations", [package], handler: {addresses in
            if let add = addresses{
                for array in add{
                    self.directionsList.append(array[0])
                }
                self.table.reloadData()
                self.locations = add
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //table view functions//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let adressesCell = tableView.dequeueReusableCell(withIdentifier: "address_cell") as! DonatorAddressCell
            
            adressesCell.address_name.text = directionsList[indexPath.row]
            adressesCell.index = indexPath.row
            adressesCell.setController(donatordirectController: self)
            return adressesCell
        
    }
    ////
    
}
