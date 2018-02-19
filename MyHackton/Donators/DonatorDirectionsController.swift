import UIKit

class DonatorDirectionsController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
     @IBOutlet var table: UITableView!
    
    //addresses example before server
    var DirectionsList: [String] = []
    
    var selectedIndex: Int!
    var package: String!
    var locations : [[String]]!
    
    
    override func viewWillAppear(_ animated: Bool) {
        //disable the "מלא פרטים" button
        tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = false
        tabBarController!.navigationItem.rightBarButtonItem!.title = ""

        //disable the next page back button - want to make alert look
        tabBarController!.navigationItem.backBarButtonItem!.isEnabled = false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "address_cell") as! DonatorAddressCell
        cell.address_name.text = DirectionsList[indexPath.row]
        cell.index = indexPath.row
        cell.setController(donatordirectController: self)
        return cell
    }
    



}
