import Foundation

public class Request {
    private var id : String!
    private var fullName : String!
    private var address : String!
    private var phoneNumber : String!
    private var notice : String!
    private var status : String!
    private var date : String!
    
    init() {}
    
    init(id: String, fullName: String, address: String, phoneNumber: String, notice: String, status: String, date: String) {
        self.id = id
        self.fullName = fullName
        self.address = address
        self.phoneNumber = phoneNumber
        self.notice = notice
        self.status = status
        self.date = date
    }
    
    func getId() -> String {
        return id
    }
    
    func getFullName() -> String {
            return fullName
        }
    
    func setFullName(name: String){
            fullName = name
        }
    
    func getAddress() -> String {
            return address
        }
    
    func setAdress(adress: String){
            self.address = adress
        }
    
    func getPhoneNumber() -> String {
            return phoneNumber
        }
    
    func setPhoneNumber(phoneNumber: String){
            self.phoneNumber = phoneNumber
        }
    
    func getNotices() -> String {
            return notice
        }
    
    func getDate() -> String {
        return date
    }
    
    func setNotices(notices: String){
            self.notice = notices
        }
    
    
}
