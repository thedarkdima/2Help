import UIKit

class DonatorDirectionsController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
     @IBOutlet var table: UITableView!
    
    //addresses example before server
    var DirectionsList: [String] = []
    
    var selectedIndex: Int!
    var package: String!
    var locations : [[String]]!
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController!.navigationItem.backBarButtonItem!.title = ""

    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        selectedIndex = self.tabBarController!.selectedIndex
        if selectedIndex == 1{
            tabBarController!.title = "סניפים"
        }else{
            tabBarController!.title = "סופרים סביבי"
        }
        
        if selectedIndex == 1 {
            
            package = "warehouse"
        }else {
            package = "supermarket"
        }
            DirectionsList = []
        ServerConnections.getDoubleArrayAsync("/locations", package, handler: {addresses in
            if let add = addresses{
                for array in add{
                    self.DirectionsList.append(array[0])
                }
                self.table.reloadData()
                self.locations = add
            }
        })
        print(selectedIndex)
    
    }
   
    public var i : Int!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DirectionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        
        if selectedIndex  == 2 {
           let productsCell = tableView.dequeueReusableCell(withIdentifier: "products_cell") as! ProductsTableViewCell
            
            return productsCell
        }
        else {
            let adressesCell = tableView.dequeueReusableCell(withIdentifier: "address_cell") as! DonatorAddressCell
            
            adressesCell.address_name.text = DirectionsList[indexPath.row]
            adressesCell.index = indexPath.row
            adressesCell.setController(donatordirectController: self)
            return adressesCell
        }
    }
    



}
