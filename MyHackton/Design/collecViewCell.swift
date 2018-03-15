import UIKit
import WebKit

class collecViewCell: UICollectionViewCell {

    @IBOutlet var container1: UIView!
 
    @IBOutlet var webView: WKWebView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let url = URL(string: "https://www.youtube.com/embed/ucts039wCPo")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
        
        DispatchQueue.main.async {
            self.container1.layer.cornerRadius = 15.0
            self.container1.layer.shadowColor = UIColor.gray.cgColor
            self.container1.layer.shadowOpacity = 0.3
            self.container1.layer.shadowOpacity = 0.3
            self.container1.layer.shadowOffset = .zero
            self.container1.layer.shadowPath = UIBezierPath(rect: self.container1.bounds).cgPath
            self.container1.layer.shouldRasterize = true
            
            
        }
        
    }

}
