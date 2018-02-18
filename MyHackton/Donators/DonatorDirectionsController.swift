import UIKit

class DonatorDirectionsController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
     @IBOutlet var table: UITableView!
    
    //addresses example before server
    var DirectionsList: [String] = []
    
    var selectedIndex: Int!
    var addon: String!
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = false
        tabBarController!.navigationItem.rightBarButtonItem!.title = ""
        if selectedIndex == 1{
            tabBarController!.title = "סניפים"
        }else{
            tabBarController!.title = "סופרים סביבי"
        }

        if selectedIndex == 1 {
            DirectionsList = []
            addon = "/addresses"
        }else{
            addon = "/super"
        }
        
        ServerConnections.getDoubleArrayAsync(addon, "", handler: {addresses in
            if let add = addresses{
                for array in add{
                    self.DirectionsList.append(array[0])
                }
                self.table.reloadData()
            }
        })

    }

    
    override func viewDidAppear(_ animated: Bool) {
        selectedIndex = self.tabBarController!.selectedIndex
        print(selectedIndex)
    
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DirectionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address_cell") as! DonatorAddressCell
        cell.address_name.text = DirectionsList[indexPath.row]
        
        return cell
    }

}
