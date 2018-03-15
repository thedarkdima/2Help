import UIKit
import WebKit
import SafariServices

class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    //var collectionVideos : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let prefs = UserDefaults.standard
        prefs.set([:], forKey: "basket")
        
        setCollectionViewProperties()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = false
        if let token = prefs.string(forKey: "token"){
            ServerConnections.getDoubleArrayAsync("/token_login", [token], handler: {array in
                if let arr = array{
                    if(arr.count > 0){
                        //Job
                        let job = arr[0][0]
                        switch(job){
                        case "שליח":
                            print("שליח")
                            self.ConnectAsDeliveryGuy(false)
                            break
                        case "מחסנאי":
                            print("מחסנאי")
                            self.ConnectAsStorageKeeper(false)
                            break
                        case "מנהל רשת":
                            print("מנהל רשת")
                            self.ConnectAsNetManager(false)
                            break
                        default:
                            print("Old token")
                        }
                    }}
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper.jpg")!)
        collectionView.backgroundColor = UIColor.clear
        
    }

    @IBAction func toSafari(_ sender: UIButton) {
        let url = URL(string: "https://www.2help.org.il/food")!
        let svc = SFSafariViewController(url: url)
        show(svc, sender: self)
    }
    
    @IBAction func login() {
        //alert when pressing the login button
        let alert =  UIAlertController(title: "התחברות", message: "הכנס שם משתמש וסיסמא", preferredStyle: .alert)
        
        alert.addTextField { (tf) in      // textfiled of the username
            tf.placeholder = "שם משתמש"
            tf.textAlignment = .right
            tf.returnKeyType = .next
            
        }
        
        alert.addTextField { (tf) in    // textfield of the password
            tf.placeholder = "סיסמא"
            tf.textAlignment = .right
            tf.isSecureTextEntry = true
            tf.returnKeyType = .done
        }
        
       let  usernameTF = alert.textFields![0]
       let  passwordTF = alert.textFields![1]
        
        func checkLogin(alert:UIAlertAction){
            let username = usernameTF.text!
            let password = passwordTF.text!
            
            //Server Auth
            //The username and password will be sent to the server, the server will return a token and a job in array.
            //After that if the server returend data that meants the user was found and takes the user to his page.
            ServerConnections.getArrayAsync("/login", [username, password], handler: {array in
                if let arr = array{
                    if(arr.count > 0){
                        //Tokken from the server
                        let prefs = UserDefaults.standard
                        prefs.set(arr[0], forKey: "token")
                        //Job
                        let job = arr[1]
                        switch(job){
                        case "שליח":
                            print("שליח")
                            self.ConnectAsDeliveryGuy(true)
                            break
                        case "מחסנאי":
                            print("מחסנאי")
                            self.ConnectAsStorageKeeper(true)
                            break
                        case "מנהל רשת":
                            self.ConnectAsNetManager(true)
                            break
                        default:
                            print("not found")
                            self.login()
                        }
                    }}
                     else {
                        self.login()
                    }
            })
        }
        
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "התחבר", style:.default , handler: checkLogin))
        
        present(alert , animated: true, completion: nil)
        }
    
    private func ConnectAsDeliveryGuy(_ animation: Bool){
        let next = storyboard!.instantiateViewController(withIdentifier: "mapAddress")
        navigationController?.pushViewController(next, animated: animation)
    }
    
    private func ConnectAsStorageKeeper(_ animation: Bool){
        let next = storyboard!.instantiateViewController(withIdentifier: "storage_main")
        navigationController?.pushViewController(next, animated: animation)
    }
    
    private func ConnectAsNetManager(_ animation: Bool){
        let next = storyboard!.instantiateViewController(withIdentifier: "net_manager")
        //navigationController?.pushViewController(next, animated: animation)
        //present(next , animated: animation, completion: nil)
        navigationController?.pushViewController(next, animated: animation)
    }
    
    
    
    ////collection view////
   
    
    func setCollectionViewProperties(){
        
        collectionView.register(UINib.init(nibName: "collecViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        
        let flowLayout = UPCarouselFlowLayout()
        
        flowLayout.itemSize = CGSize(width: collectionView.frame.size.width-30, height: collectionView.frame.size.height-50)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        collectionView.collectionViewLayout = flowLayout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collecViewCell
        
        let urlsRequests = URLRequest(url: cell.urls[indexPath.item])
        cell.webView.load(urlsRequests)
        
        return cell
    }
    
    ////
        
}
