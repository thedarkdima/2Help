import UIKit

class DonatorProductsCell: UITableViewCell {
    
    // maybe we should put text field that the man can also write not only press + / -
    @IBOutlet var productName: UILabel!
    @IBOutlet var minusLabel: UIButton!
    @IBOutlet var numberOfProducts: UILabel!
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberOfProducts.text = "\(count)"
        if count == 0{
            minusLabel.isEnabled = false
        }
        

    }

    @IBAction func plusButton(_ sender: UIButton) {
        count += 1
        numberOfProducts.text = "\(count)"
        minusLabel.isEnabled = true
    }
    
    @IBAction func minusButton(_ sender: UIButton){
        if count > 0{
            minusLabel.isEnabled = true
            count -= 1
            numberOfProducts.text = "\(count)"
            if count == 0 {
                minusLabel.isEnabled = false
            }
           
        }
        
    }
}
