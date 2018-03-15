import UIKit

class NetManagerUsersController: UIViewController{
    var user:[String] = []
    var toDo: String!
    
    @IBOutlet var username: UITextField!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var fullname: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var address: UITextField!
    
    override func viewDidLoad() {
        if (toDo == "update"){
            toDoBtn.setTitle("הדכן", for: .normal)
        } else {
            toDoBtn.setTitle(toDo, for: .normal)
        }
        
        username.text = user[1]
        fullname.text = user[4]
        //phone.text = user[4]
        //address.text = user[5]
    }
    
    @IBOutlet var toDoBtn: UIButton!
    @IBAction func btnPress(_ sender: Any) {
        let prefs = UserDefaults.standard
        if let token = prefs.string(forKey: "token"){
            switch toDo {
            case "add":
                ServerConnections.getDoubleArrayAsync("/add_user", [[token], user], handler: {array in
                    
                })
            case "update":
                ServerConnections.getDoubleArrayAsync("/update_user", [[token], user], handler: {array in
                    
                })
            default:
                break
            }
        }
    }
}
