import UIKit

class ProductsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var counter: UITextField!
    @IBOutlet weak var minus_Label: UIButton!
    var count : Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        count = 0
        counter.text = "\(count)"
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
