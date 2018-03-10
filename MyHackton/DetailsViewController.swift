import UIKit

class DetailsViewController: UIViewController {
     /////////////////////////////////////////////////  בדיקה - עמוד מיותר ///////////////////////////////////
    public var scannedCode:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        print(scannedCode!)
        
        
        // add the barCode label to the view and customize it
        view.addSubview(codeLabel)
        
        //
        codeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        codeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        codeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        codeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        if let scannedCode = scannedCode {
            codeLabel.text = scannedCode
        }
        
        // add the scan button to the view and customize it
        view.addSubview(scanButton)
        scanButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        scanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scanButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scanButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    //design barcode label
    let codeLabel:UILabel = {
        let codeLabel = UILabel()
        codeLabel.textAlignment = .center
        codeLabel.backgroundColor = .white
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        return codeLabel
    }()
    
    //design scan button
    var scanButton:UIButton = {
        let scanButton = UIButton(type: .system)
        scanButton.setTitle("scan", for: .normal)
        scanButton.setTitleColor(.white, for: .normal)
        scanButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        scanButton.backgroundColor = .blue
        scanButton.layer.cornerRadius = 25
        scanButton.addTarget(self, action: #selector(displayScannerViewController), for: .touchUpInside)
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        
        return scanButton
    }()
    
    @objc func displayScannerViewController() {
        print("123")
        let scanViewController = storyboard!.instantiateViewController(withIdentifier: "scanner")
        //navigationController?.pushViewController(scanViewController, animated: true)
        //navigationController?.present(scanViewController, animated: true, completion: nil)
        present(scanViewController, animated: true, completion: nil)
    }
    
}

