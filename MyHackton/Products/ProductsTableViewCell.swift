import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet var product_image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var counter: UITextField!
    @IBOutlet var minus_Label: UIButton!
    var count : Int = 0
    var manager = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        count = 0
        counter.text = "\(count)"
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    
     func setName(name: String){
        self.name.text = name
    }

    @IBAction func plusBtn(_ sender: UIButton) {
        count += 1
        counter.text = ("\(count)")
        minus_Label.isEnabled = true
        updateBasket()
    }
    
    @IBAction func minusBtn(_ sender: UIButton) {
        if counter.text != "0"{
            count -= 1
            counter.text = ("\(count)")
        } else if counter.text == "0" {
            minus_Label.isEnabled = false
        }
        updateBasket()
    }
    
    func updateBasket(){
        if !manager{
            let prefs = UserDefaults.standard
            var basket:[String: [String]] = [:]
            if let prefsBasket = prefs.dictionary(forKey: "basket"){
                basket = prefsBasket as! [String: [String]]
                if let keyExists = basket[name.text!]{
                    basket.updateValue([String(count), keyExists[1]], forKey: name.text!)
                }
            }
            prefs.set(basket, forKey: "basket")
        }
    }
}
