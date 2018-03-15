import UIKit
import WebKit

class collecViewCell: UICollectionViewCell {

    @IBOutlet var container1: UIView!
    @IBOutlet var webView: WKWebView!
  
    
    let urls : [URL] = [URL(string: "https://d.ibtimes.co.uk/en/full/1464094/baby-hand.jpg?w=700")!,
                        URL(string: "https://www.yumama.com/thumbnail.php?file=2014/07/najpopularnija_zenska_imena_u_hrvatskoj_aps_978079305.jpg&size=article_large" )!,
                        URL(string: "http://alwaysbusymama.com/images/content/383-zdorovyj-detskij-son-10-pravil.jpg")!,
                        URL(string: "https://www.youtube.com/embed/ucts039wCPo" )!,
                        URL(string: "https://m.static.lagardere.cz/frekvence1/edee/clanky/21974/kluk.jpg")!
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        DispatchQueue.main.async {
            self.container1.layer.cornerRadius = 15.0
            self.container1.layer.shadowColor = UIColor.lightGray.cgColor
            self.container1.layer.shadowOpacity = 0.2
            self.container1.layer.shadowOpacity = 0.2
            self.container1.layer.shadowOffset = .zero
            self.container1.layer.shadowPath = UIBezierPath(rect: self.container1.bounds).cgPath
            self.container1.layer.shouldRasterize = true
            
            
        }
        
    }

}
