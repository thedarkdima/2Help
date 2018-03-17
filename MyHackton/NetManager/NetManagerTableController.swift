import UIKit

class NetManagerTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //var array = [" ", "משתמשים", "מוצרים", "סוגי מוצרים", "כתובות", "תמונות וידיו"]
    var user:[String]!
    var token:String!
    
    @IBOutlet var table: UITableView!
    var tableArray: [[String]] = []
    @IBOutlet var searchTextField: UITextField!
    var searchArray: [[String]] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper.jpg")!)
        table.backgroundColor = UIColor.clear
        
        let prefs = UserDefaults.standard
        if let tok = prefs.string(forKey: "token"){
            token = tok
            switch type {
            case "משתמשים":
                ServerConnections.getDoubleArrayAsync("/all_users", [tok], handler: { array in
                    self.setTableArray(array: array)
                })
            case "מוצרים":
                ServerConnections.getDoubleArrayAsync("/all_items", [tok], handler: { array in
                    self.setTableArray(array: array)
                })
            case "סוגי מוצרים":
                ServerConnections.getDoubleArrayAsync("/itemstypes", [""], handler: { array in
                    self.setTableArray(array: array)
                })
            case "כתובות":
                ServerConnections.getDoubleArrayAsync("/all_locations", [tok], handler: { array in
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
            searchArray = tableArray
            table.reloadData()
        }
    }
    
    func searching(){
        if searchTextField.text! != ""{
            searchArray.removeAll()
            for array in tableArray{
                for str in array{
                    if str.lowercased().range(of: searchTextField.text!.lowercased()) != nil {
                        searchArray.append(array)
                        break
                    }
                }
            }
        } else {
            searchArray = tableArray
        }
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "netmanager_cell") as! NetManagerTableCell
//        if(RequestsList.count > 0){
//            cell.address.text = RequestsList[indexPath.row].getAddress()
//            findDistanceBetweenPins(cell: cell)
        //        }
        
        switch type {
        case "משתמשים":
            cell.lable.text = searchArray[indexPath.row][1] + " :" + searchArray[indexPath.row][3]
        case "מוצרים":
             cell.lable.text = searchArray[indexPath.row][0]
        case "סוגי מוצרים":
            cell.lable.text = searchArray[indexPath.row][0]
        case "כתובות":
            cell.lable.text = searchArray[indexPath.row][0]
        case "תמונות וידיו":
             cell.lable.text = searchArray[indexPath.row][0]
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
        switch toDo {
        case "delete":
            user = searchArray[indexPath.row]
            deleteAlert(index: indexPath)
        case "update":
            
            let next = storyboard!.instantiateViewController(withIdentifier: "net_manager_users") as! NetManagerUsersController
            next.toDo = toDo
            next.user = searchArray[indexPath.row]
            navigationController?.pushViewController(next, animated: true)
            
        default:
            break
        }
    }
    
    func deleteAlert(index: IndexPath) {
        //alert when pressing the login button
        let alert =  UIAlertController(title: "מחיקה", message: "אתה בטוח שאתה רוצה למחוק את \((table.cellForRow(at: index) as! NetManagerTableCell).lable.text!)?", preferredStyle: .alert)
        
        func deleteFromDB(alert:UIAlertAction){
            ServerConnections.getDoubleArrayAsync("/delete_user", [[self.token], self.user], handler: {array in
                self.viewWillAppear(false)
                let alert = UIAlertController(title: "התרעה", message: "המשתמש נמחק בהצלחה", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "אישור", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            })
        }
        
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "מחק", style:.default , handler: deleteFromDB))
        
        present(alert , animated: true, completion: nil)
    }
    
    var type: String!
    var toDo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func search(_ sender: Any) {
        searching()
    }
}



