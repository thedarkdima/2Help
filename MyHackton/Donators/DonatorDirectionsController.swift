import UIKit

class DonatorDirectionsController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var table: UITableView!
    
    var directionsList: [String] = []
    
    var selectedIndex: Int!
    var package: String!
    var locations : [[String]]!
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController!.navigationItem.backBarButtonItem!.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //check which tab bar page is active
        
        selectedIndex = self.tabBarController!.selectedIndex
        if selectedIndex == 1{
            tabBarController!.title = tabBarItem!.title
            package = "warehouse"
            
        }else {
            tabBarController!.title = tabBarItem!.title
            package = "supermarket"
        }
        
        directionsList = []
        
        ServerConnections.getDoubleArrayAsync("/locations", package, handler: {addresses in
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
     
        if selectedIndex  == 2 {
           let productsCell = tableView.dequeueReusableCell(withIdentifier: "products_cell") as! ProductsTableViewCell
            
            return productsCell
        }else {
            let adressesCell = tableView.dequeueReusableCell(withIdentifier: "address_cell") as! DonatorAddressCell
            
            adressesCell.address_name.text = directionsList[indexPath.row]
            adressesCell.index = indexPath.row
            adressesCell.setController(donatordirectController: self)
            return adressesCell
        }
    }
    ////
    
}
