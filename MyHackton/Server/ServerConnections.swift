import Foundation


class ServerConnections{
    //Connection to the server with url addon and if needed with package of string, returning an array or a dobule array of
    //String from the server.
    static func getArrayAsync(_ urlAddon: String, _ package: String, handler: @escaping ([String]?)->()) {
        let url = URL(string: "http://2help-server.eu-gb.mybluemix.net" + urlAddon)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = package.data(using: .utf8)
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
    
    static func getDoubleArrayAsync(_ urlAddon: String, _ package: String, handler: @escaping ([[String]]?)->()) {
        let url = URL(string: "http://2help-server.eu-gb.mybluemix.net" + urlAddon)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = package.data(using: .utf8)
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
    
//    static func getDonators() -> [Donator]{
//        getDictonaryAsync("/donators", "", handler: { donators in
//            var back: [Donator]
//            if let d = donators{
//                for donator in d {
//
//                }
//            }
//
//        })
//        return back
//    }
}
