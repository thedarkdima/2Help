import UIKit

class NetManagerTableCell: UITableViewCell {
    

    @IBOutlet var lable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
    }
    
    
}
