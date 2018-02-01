import Foundation


class ServerConnections{
    
    static func getArrayAsync(_ urlAddon: String, _ tokken: String, handler: @escaping ([String]?)->()) {
        let url = URL(string: "http://2help-server.eu-gb.mybluemix.net" + urlAddon)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = tokken.data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: {(d,r,e) in
            if let data = d {
                //call handler with result (in main thread)
                DispatchQueue.main.async {
                    handler((try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String])
                }
            }
            else {
                print("Nil Data.")
            }
        }).resume()
    }
    
    static func getDictonaryAsync(_ urlAddon: String, _ tokken: String, handler: @escaping ([[String]]?)->()) {
        let url = URL(string: "http://2help-server.eu-gb.mybluemix.net" + urlAddon)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = tokken.data(using: .utf8)
        URLSession.shared.dataTask(with: request, completionHandler: {(d,r,e) in
            if let data = d {
                //call handler with result (in main thread)
                DispatchQueue.main.async {
                    handler((try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [[String]])
                }
            }
            else {
                print("Nil Data.")
            }
        }).resume()
    }
    
    
    
    ////////////////////////////////////////
    //Examples, Nothing More Nothing Less.//
    ////////////////////////////////////////
    static func getArray1(_ urlAddon: String, _ tokken: String) -> [String] {
        let url = URL(string: "http://2help-server.eu-gb.mybluemix.net" + urlAddon)!
        var request = URLRequest(url: url)
        var products2: [String] = []
        request.httpMethod = "POST"
        request.httpBody = tokken.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(d,r,e) in
            AsyncTask(backgroundTask: { (d: Data) -> [String]? in
                return (try? JSONSerialization.jsonObject(with: d, options: .mutableContainers)) as? [String]
            }, afterTask: { products in
                //self.products = products ?? []
                if products == nil {
                    print("nil was found HERE")
                }
                else {
                    print(products!)
                    products2 = products!
                    //self.tbl_products.reloadData()
                }
            }).execute(d!)
        }).resume()
        return products2
    }
    
    static func example(_ urlAddon: String) {
        // show the products from the srever in a new task
        //let url = URL(string: "http://2help-server.eu-gb.mybluemix.net" + urlAddon)!
        
        let url = URL(string: "http://2help-server.eu-gb.mybluemix.net/hello")!
        var request = URLRequest(url: url)
        //request.setValue("application/", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "Jack"
        //request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        request.httpBody = postString.data(using: .utf8)
        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {                                 // check for fundamental networking error
//                print("error=\(error!)")
//                return
//            }
//
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response!)")
//            }
//
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString!)")
//        }
//        task.resume()
        
        URLSession.shared.dataTask(with: request, completionHandler: {(d,r,e) in
            AsyncTask(backgroundTask: { (d: Data) -> [String]? in
                return (try? JSONSerialization.jsonObject(with: d, options: .mutableContainers)) as? [String]
            }, afterTask: { products in
                //self.products = products ?? []
                if products == nil {
                    print("nil was found HERE")
                }
                else {
                    print(products!)
                    //self.tbl_products.reloadData()
                }
            }).execute(d!)
        }).resume()
    }
}
