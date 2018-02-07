import UIKit

class DonatorProductsCell: UITableViewCell {
    
    //design pattern: dependency injection
    var donatorController : DonatorController!
    
    // maybe we should put text field that the man can also write, not only press + / -
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
        donatorController.updateCount(c: 1)
    }
    
    @IBAction func minusButton(_ sender: UIButton){
        if count > 0{
            count -= 1
            numberOfProducts.text = "\(count)"
            if count == 0 {
                minusLabel.isEnabled = false
            }
            donatorController.updateCount(c: -1)
        }
    }
    
    func set(donatorController : DonatorController) {
        self.donatorController = donatorController
    }
    
    
}
