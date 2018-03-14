import UIKit
import WebKit
import SafariServices

class MainController: UIViewController {
    
    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let prefs = UserDefaults.standard
        prefs.set([:], forKey: "basket")
    }
    

    @IBAction func toSafari(_ sender: UIButton) {
        let url = URL(string: "https://www.2help.org.il/food")!
        let svc = SFSafariViewController(url: url)
        show(svc, sender: self)
    }
    
    @IBAction func login() {
        //alert when pressing the login button
        let alert =  UIAlertController(title: "התחברות", message: "הכנס שם משתמש וסיסמא", preferredStyle: .alert)
        
        alert.addTextField { (tf) in      // textfiled of the username
            tf.placeholder = "שם משתמש"
            tf.textAlignment = .right
            tf.returnKeyType = .next
            
        }
        
        alert.addTextField { (tf) in    // textfield of the password
            tf.placeholder = "סיסמא"
            tf.textAlignment = .right
            tf.isSecureTextEntry = true
            tf.returnKeyType = .done
        }
        
       let  usernameTF = alert.textFields![0]
       let  passwordTF = alert.textFields![1]
        
        func checkLogin(alert:UIAlertAction){
            let username = usernameTF.text!
            let password = passwordTF.text!
            
            //Server Auth
            //The username and password will be sent to the server, the server will return a token and a job in array.
            //After that if the server returend data that meants the user was found and takes the user to his page.
            ServerConnections.getArrayAsync("/login", [username, password], handler: {array in
                if let arr = array{
                    if(arr.count > 0){
                        //Tokken from the server
                        let prefs = UserDefaults.standard
                        prefs.set(arr[0], forKey: "token")
                        //Job
                        let job = arr[1]
                        switch(job){
                        case "שליח":
                            print("שליח")
                            self.ConnectAsDeliveryGuy()
                            break
                        case "מחסנאי":
                            print("מחסנאי")
                            self.ConnectAsStorageKeeper()
                            break
                        case "מנהל רשת":
                            print("good job")
                            break
                        default:
                            print("not found")
                            self.login()
                        }
                    }}
                     else {
                        self.login()
                    }
            })
        }
        
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "התחבר", style:.default , handler: checkLogin))
        
        present(alert , animated: true, completion: nil)
        }
    
    private func ConnectAsDeliveryGuy(){
        let next = storyboard!.instantiateViewController(withIdentifier: "mapAddress")
        show(next, sender: self)
    }
    
    private func ConnectAsStorageKeeper(){
        let next = storyboard!.instantiateViewController(withIdentifier: "storage_main")
        show(next, sender: self)
    }
        
}
