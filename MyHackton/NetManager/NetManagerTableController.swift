import UIKit

class NetManagerTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //var array = [" ", "משתמשים", "מוצרים", "סוגי מוצרים", "כתובות", "תמונות וידיו"]
    @IBOutlet var table: UITableView!
    var tableArray: [[String]] = []
    override func viewWillAppear(_ animated: Bool) {
        let prefs = UserDefaults.standard
        if let token = prefs.string(forKey: "token"){
            switch type {
            case "משתמשים":
                ServerConnections.getDoubleArrayAsync("/all_users", [token], handler: { array in
                    self.setTableArray(array: array)
                })
            case "מוצרים":
                ServerConnections.getDoubleArrayAsync("/all_items", [""], handler: { array in
                    self.setTableArray(array: array)
                })
            case "סוגי מוצרים":
                ServerConnections.getDoubleArrayAsync("/itemstypes", [""], handler: { array in
                    self.setTableArray(array: array)
                })
            case "כתובות":
                ServerConnections.getDoubleArrayAsync("/all_locations", [""], handler: { array in
                    self.setTableArray(array: array)
                })
            case "תמונות וידיו":
                ServerConnections.getDoubleArrayAsync("/images", [""], handler: { array in
                    self.setTableArray(array: array)
                })
            default:
                break
            }
        }
    }
    
    func setTableArray(array: [[String]]?){
        if array != nil{
            tableArray = array!
            table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "netmanager_cell") as! NetManagerTableCell
//        if(RequestsList.count > 0){
//            cell.address.text = RequestsList[indexPath.row].getAddress()
//            findDistanceBetweenPins(cell: cell)
        //        }
        switch type {
        case "משתמשים":
            cell.lable.text = ""
        case "מוצרים":
            cell.lable.text = ""
        case "סוגי מוצרים":
            cell.lable.text = tableArray[indexPath.row][0]
        case "כתובות":
            cell.lable.text = tableArray[indexPath.row][0]
        case "תמונות וידיו":
            cell.lable.text = ""
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath) as! DeliveryRequestCell
//        let next = storyboard?.instantiateViewController(withIdentifier: "statusPage") as! DonatorsStatusController
//
//        if RequestsList.count > 0 {
//            donator = RequestsList[indexPath.row]
//            next.set(donator: donator,index: indexPath.row)
//            show(next, sender: self)
//            self.navigationItem.backBarButtonItem?.title = "חזור"
//        }
    }
    
    var type: String!
    var toDo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



