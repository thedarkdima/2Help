import UIKit

class DonatorsStatusController: UIViewController ,UIPickerViewDataSource , UIPickerViewDelegate {
   
    @IBOutlet var statusPickerView: UIPickerView!
    @IBOutlet var donatorsAddressLbl: UILabel!
    
    private var address: String!
    
    //pickerView list
    private let statusList = [" ","בטיפול","בוטל","בוצע"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donatorsAddressLbl.text = address
        
    }
  //method to change address
    public func set(address: String){
        self.address = address
    }

    //picker view methods//
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusList[row]
    }
    ////
    
    @IBAction func changeStatusBtn(_ sender: UIButton) {
        
        let deliveryController = storyboard!.instantiateViewController(withIdentifier: "MyDeliveryList")
        show(deliveryController, sender: self)
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//    }
    
    
    
}
