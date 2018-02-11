import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       ServerConnections.getDictonaryAsync("/donators", "Stan", handler: {donators in
        if let dodo = donators{
            print(dodo)
        }
        else {
            print("fail")
        }
       })
    }

    
    @IBAction func login() {
        //alert when pressing the login button
        
        
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
            
            //if the details are true, a new window will open with the appropiate data(delivery guy or stockkeeper)
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
