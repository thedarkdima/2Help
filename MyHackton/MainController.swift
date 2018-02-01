import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

 
    @IBAction func login() {
        
        let alert =  UIAlertController(title: "התחברות", message: "הכנס שם משתמש וסיסמא", preferredStyle: .alert)
        
        alert.addTextField { (tf) in      // textfiled of the username
            tf.placeholder = "שם משתמש"
            tf.textAlignment = .right
        }
        
        alert.addTextField { (tf) in    // textfield of the password
            tf.placeholder = "סיסמא"
            tf.textAlignment = .right
            tf.isSecureTextEntry = true
        }
        
       let  usernameTF = alert.textFields![0]
       let  passwordTF = alert.textFields![1]
        
        func checkLogin(alert:UIAlertAction){
            let username = usernameTF.text!
            let password = passwordTF.text!
            
            if username == "matan" && password == "123" && !username.isEmpty && !password.isEmpty {
                Connect()
            } else {
                login()
            }
        }
        
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "התחבר", style:.default , handler: checkLogin))
        
        present(alert , animated: true, completion: nil)
        
        
        }
    
    private func Connect(){
       // print("connected ")
        
        let next = storyboard!.instantiateViewController(withIdentifier: "delivery_main")
        show(next, sender: self)
        
    }
        
    }
