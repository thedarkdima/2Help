import Foundation

public class Donator {
    private var fullName : String!
    private var adress : String!
    private var phoneNumber : String!
    private var notices : String!
    
    
    
    func getFullName() -> String {
            return fullName
        }
    
    func setFullName(name: String){
            fullName = name
        }
    
    func getAdress() -> String {
            return adress
        }
    
    func setAdress(adress: String){
            self.adress = adress
        }
    
    func getPhoneNumber() -> String {
            return phoneNumber
        }
    
    func setPhoneNumber(phoneNumber: String){
            self.phoneNumber = phoneNumber
        }
    
    func getNotices() -> String {
            return notices
        }
    
    func setNotices(notices: String){
            self.notices = notices
        }
    
    
}
