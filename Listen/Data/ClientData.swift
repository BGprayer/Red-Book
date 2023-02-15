//
//  ClientData.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/29.
//

import SwiftUI
import Parse
var encoder = JSONEncoder()
var decoder = JSONDecoder()

func initMyClientData() -> Client{
    var output : Client = Client(username: "", clientname: "", introduction: "", sex: "", locate: "", clientimage: "", clientbackground: "",birthday: Date(),school: "")
    if let datastore = UserDefaults.standard.object(forKey: "MyClient") as? Data{
        let data = try! decoder.decode(Client.self,from: datastore)
        output = data
    }
    return output
}

class ClientData : ObservableObject{
    @Published var MyClient : Client
    @Published var saveresult = false
    init(FromOutMyClient : Client){
        self.MyClient = FromOutMyClient
    }
    
    func datastore(){
        let datastore = try! encoder.encode(self.MyClient)
        UserDefaults.standard.set(datastore, forKey: "MyClient")
    }
    
    func ServerSave(ChangeName:String,ChangeContent:Any){
        var query = PFUser.query()
        query?.whereKey("username", contains: self.MyClient.username)
        query?.findObjectsInBackground{ user, error in
            if(error != nil){
                print("发现错误")
            }
            else if let user = user{
                user[0][ChangeName] = ChangeContent
                user[0].saveInBackground{success, error in
                    self.saveresult = success
                }
            }
        }
    }
    
    func RefreshData(Refreshname:String){
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo:self.MyClient.username)
        query?.getFirstObjectInBackground{ user, error in
            if user != nil{
                switch Refreshname{
                    case "clientname"  :
                        let clientname = user!.object(forKey: "username") as! String
                        self.MyClient.clientname = clientname
                        self.datastore()
                        return
                    case "introduction" :
                        let introduce = user!.object(forKey: "introduction") as! String
                        self.MyClient.introduction = introduce
                        self.datastore()
                        return
                    case "sex" :
                        let sex = user!.object(forKey: "sex") as! String
                        self.MyClient.sex = sex
                        self.datastore()
                        return
                    case "locate" :
                        let locate = user!.object(forKey: "locate") as! String
                        self.MyClient.locate = locate
                        self.datastore()
                        return
                    case "clientimage":
                        let clientimage = user!["clientimage"] as! PFFileObject
                        self.MyClient.clientimage = clientimage.url!
                        self.datastore()
                        return
                    case "clienbakground" :
                        let backgrounimage = user!["clientbackground"] as! PFFileObject
                        self.MyClient.clientbackground = backgrounimage.url!
                        self.datastore()
                        return
                    case "school" :
                        let school = user!.object(forKey: "school") as! String
                        self.MyClient.school = school
                        self.datastore()
                        return
                    case "birthday" :
                        let birthday = user!.object(forKey: "birthday") as! Date
                        self.MyClient.birthday = birthday
                        self.datastore()
                        return
                    default:
                        return
                }
            }
        }
    }
    
    func ServerSaveImage(ChangeName:String,ChangeContent:Data){
        var query = PFUser.query()
        query?.whereKey("username", contains: self.MyClient.username)
        query?.findObjectsInBackground{ user, error in
            if(error != nil){
                print("发现错误")
            }
            else if let user = user{
                let imagefile = PFFileObject(name: "image.png", data: ChangeContent)!
                user[0][ChangeName] = imagefile
                user[0].saveInBackground{success, error in
                    self.UpdateClientImage(username: self.MyClient.username, changename: ChangeName, result: success, imagefile: imagefile)
                }
            }
        }
    }
    
    func string(from data: PFFileObject) -> String {
            return String(format: "%@", data as CVarArg)
    }
    
    func UpdateClientImage(username:String,changename:String,result:Bool,imagefile:PFFileObject){
        let query = PFUser.query()
        query?.whereKey("objectId", contains: self.MyClient.username)
        query?.findObjectsInBackground{ user, error in
            if(error != nil){
                print("发现错误")
            }else if let user = user{
                let newimage = imagefile
                let newimageurl = newimage.url!
                if changename == "clientimage"{
                    self.MyClient.clientimage = newimageurl
                    self.saveresult = result
                    self.datastore()
                }else{
                    self.MyClient.clientbackground = newimageurl
                    self.saveresult = result
                    self.datastore()
                }
            }
        }
    }
    
}

struct Client : Identifiable,Decodable,Encodable,Equatable{
    var id = UUID()
    var username : String
    var clientname : String
    var introduction : String
    var sex : String
    var locate : String
    var clientimage : String
    var clientbackground : String
    var birthday : Date
    var school : String
}
