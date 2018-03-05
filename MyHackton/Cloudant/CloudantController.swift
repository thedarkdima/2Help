import Foundation

let HOST = "https://c39963ca-4ac8-4a43-bef7-62cd677a2e64-bluemix.cloudant.com"
let USERNAME = "c39963ca-4ac8-4a43-bef7-62cd677a2e64-bluemix"
let PASSWORD = "619067301eeb06a7b79a03c5397caec1ba7886b83f963b0a54191578ed7dae60"
let cloudantURL = NSURL(string: HOST)!
let client = CouchDBClient(url: cloudantURL as URL, username: USERNAME, password: PASSWORD)

enum databases: String {
    case donators
    case users
    case products
    case main
    case locations
}

class CloudantController{
    static func addUser(id: String, username: String, password: String, job: String, full_name: String, phone: String, address: String){
        let create = PutDocumentOperation(id: id, body: ["username": username, "password": password, "job": job, "full_name": full_name, "phone": phone, "address": address], databaseName: "\(databases.users)") {(response, httpInfo, error) in
            if let error = error {
                print("Encountered an error while creating a document. Error:\(error)")
            } else {
                print("Created document \(String(describing: response?["id"])) with revision id \(String(describing: response?["rev"]))")
            }
        }
        client.add(operation: create)
    }
    
    static func addDonator(name: String, address: String, phone: String, notice: String){
        let create = PutDocumentOperation(id: nil, body: ["name": name, "address": address, "phone": phone, "notice": notice], databaseName: "\(databases.donators)") {(response, httpInfo, error) in
            if let error = error {
                print("Encountered an error while creating a document. Error:\(error)")
            } else {
                print("Created document \(String(describing: response?["id"])) with revision id \(String(describing: response?["rev"]))")
            }
        }
        client.add(operation: create)
    }
    
    static func addProduct(name: String, category: String, type: String, pryority: String){
        let create = PutDocumentOperation(id: nil, body: ["name": name, "category": category, "type": type, "pryority": pryority], databaseName: "\(databases.products)") {(response, httpInfo, error) in
            if let error = error {
                print("Encountered an error while creating a document. Error:\(error)")
            } else {
                print("Created document \(String(describing: response?["id"])) with revision id \(String(describing: response?["rev"]))")
            }
        }
        client.add(operation: create)
    }
    
    static func addLocation(name: String, address: String, phone: String, working_time: String){
        let create = PutDocumentOperation(id: nil, body: ["name": name, "address": address, "phone": phone, "working_time": working_time], databaseName: "\(databases.locations)") {(response, httpInfo, error) in
            if let error = error {
                print("Encountered an error while creating a document. Error:\(error)")
            } else {
                print("Created document \(String(describing: response?["id"])) with revision id \(String(describing: response?["rev"]))")
            }
        }
        client.add(operation: create)
    }
}
