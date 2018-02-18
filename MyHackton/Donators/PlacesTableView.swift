
import UIKit

class PlacesTableView: UITableView, UITableViewDataSource {
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return DirectionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address_cell") as! DonatorAddressCell
        cell.address_name.text = DirectionsList[indexPath.row]
        
        return cell
    }
    

}
