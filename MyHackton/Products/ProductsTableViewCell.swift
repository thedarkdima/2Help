import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet var product_image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var counter: UITextField!
    @IBOutlet var minus_Label: UIButton!
    var count : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        count = 0
        counter.text = "\(count)"
    }
    
     func setName(name: String){
        self.name.text = name
    }

    @IBAction func plusBtn(_ sender: UIButton) {
        count += 1
        counter.text = ("\(count)")
        minus_Label.isEnabled = true
    }
    
    @IBAction func minusBtn(_ sender: UIButton) {
        if counter.text != "0"{
            count -= 1
            counter.text = ("\(count)")
        } else if counter.text == "0" {
            minus_Label.isEnabled = false
        }
    }
    
}
