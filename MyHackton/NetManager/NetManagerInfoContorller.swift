import UIKit

class NetManagerInfoController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var picker: UIPickerView!
    var array = [" ", "משתמשים", "מוצרים", "סוגי מוצרים", "כתובות", "תמונות/וידאו"]
    
    var type: String! // var to check which type to add to the system
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper.jpg")!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem?.title = "חזור"
    }
    
    //// picker view functions////
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        picker.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        picker.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type = array[row]
    }
    ////
    
    // add function
    @IBAction func addBtn(_ sender: Any) {
        if type != nil && type != " "{
            switch type {
            case "משתמשים":
                let next = storyboard!.instantiateViewController(withIdentifier: "net_manager_users") as! NetManagerUsersController
                next.toDo = "add"
                navigationController?.pushViewController(next, animated: true)
            default:
                break
            }
        }
    }
    
    // update function
    @IBAction func changeBtn(_ sender: Any) {
        if type != nil && type != " "{
            let next = storyboard!.instantiateViewController(withIdentifier: "net_manager_table") as! NetManagerTableController
            next.type = type
            next.toDo = "update"
            navigationController?.pushViewController(next, animated: true)
        }
    }
    
    //delete function
    @IBAction func delBtn(_ sender: Any) {
        if type != nil && type != " "{
            let next = storyboard!.instantiateViewController(withIdentifier: "net_manager_table") as! NetManagerTableController
            next.type = type
            next.toDo = "delete"
            navigationController?.pushViewController(next, animated: true)
        }
    }
    
}
