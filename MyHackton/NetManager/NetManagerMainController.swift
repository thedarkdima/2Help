import UIKit

class NetManagerMainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let b = UIBarButtonItem(title: "התנתק", style: .plain, target: self, action: #selector(backcheck))
        //presentationController?.navigationItem.leftBarButtonItem = b
        navigationItem.leftBarButtonItem = b
        self.navigationItem.hidesBackButton = true
    }
    
    //logout from the system
    @objc func backcheck(){
        //let main = storyboard!.instantiateViewController(withIdentifier: "main")
        let alert =  UIAlertController(title:"יציאה מהמערכת", message: "האם אתה בטוח שברצונך להתנתק מהמערכת?", preferredStyle: .alert)
        
        func okHandler(alert: UIAlertAction!){
            navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "אישור", style: .default, handler: okHandler))
        
        present(alert, animated: true, completion: nil)
        
    }
}

