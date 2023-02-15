//
//  PyqData.swift
//  Listen
//
//  Created by 项宇杰 on 2022/9/12.
//

import SwiftUI
import Parse

func initPqyData() -> [Carddata]{
    var output : [Carddata] = []
    if let datastore = UserDefaults.standard.object(forKey: "allPyqData") as? Data{
        let data = try! decoder.decode([Carddata].self, from: datastore)
        output = data
    }
    return output
}

func GetUserimageUrl(objectid:String) ->String{
    var url : String = ""
    let query = PFUser.query()
    print(objectid)
    query?.whereKey("objectId", contains: objectid)
    query?.getFirstObjectInBackground(block: { object, error in
        if object != nil{
            let clientimage = object!["clientimage"] as! PFFileObject
            url = clientimage.url!
            print(url)
        }
    })
    return url
}

class PYQData : ObservableObject{
    @ObservedObject var  Myclientdata  : ClientData = ClientData(FromOutMyClient: initMyClientData())
    @Published var alerttext = ""
    @Published var allPyqData : [Carddata]
    @Published var refresh : Bool = false
    @Published var refreshcount  = 0
    @Published var PinLun : [MyPinlun] = []
    @AppStorage("islogin") var islogin = false
    
    init(allPyqData : [Carddata]){
        self.allPyqData = allPyqData
    }
    
    func datastore(){
        let datastore = try! encoder.encode(self.allPyqData)
        UserDefaults.standard.set(datastore, forKey: "allPyqData")
    }
    
    func sort(allPyqData : [Carddata]) -> [Carddata]{
        var  newallPyqData : [Carddata] = []
        newallPyqData = allPyqData.sorted(by: {$0.publishtime < $1.publishtime})
        return newallPyqData
    }
    
    func sort2(allPyqData : [Carddata]){
        withAnimation {
            self.allPyqData = allPyqData.sorted(by: {$0.publishtime < $1.publishtime})
            self.datastore()
        }
    }
    
    func UpLoadMyPyq(data:Carddata,image:[myimage],objectid:String){
        print("image\(image)")
        for i in 0..<image.count{
            print(1)
            let pyqimage = PFObject(className: "Pyqimages")
            let imageData =  image[i].imagedata!
                let imagefile = PFFileObject(name:"image.png", data: imageData)!
                pyqimage["userobjectid"] = objectid
                pyqimage["imagecount"] = image.count
                pyqimage["image"] = imagefile
                pyqimage["title"] = data.title
                pyqimage["content"] = data.content
                pyqimage.saveInBackground(){ (succeed,error) in
                    if succeed{
                        print("图像上传成功")
                    }else{
                        self.alerttext = "上传失败!"
                        print("图像上传失败")
                        return
                    }
                }
        }
        print(2)
        let pyqdatas = PFObject(className: "Card")
        pyqdatas["userobjectId"] = objectid
        pyqdatas["title"] = data.title
        pyqdatas["content"] = data.content
        pyqdatas["locate"] = data.locate
        pyqdatas["love"] = 0
        pyqdatas["star"] = 0
        pyqdatas.saveInBackground(){(succeed,error) in
            if succeed{
                self.alerttext = "发表成功!"
                print("上传成功")
            }else{
                self.alerttext = "发表失败,请重试"
                print("上传失败")
                return
            }
        }
    }
    

    
    func downloading(currentpage:Int){
        if currentpage == 0{
            print("10086\(currentpage)")
            withAnimation {
                self.allPyqData.removeAll()
            }
        }
        let count1 = self.allPyqData.count
        let count = currentpage * count1
        guard self.allPyqData.count < count + count1 + 1 else {return}
        print("10087\(self.allPyqData.count)")
        DispatchQueue.global(qos: .userInteractive).async {
            let query = PFQuery(className: "Card")
//            query.whereKey("objectId", notEqualTo: 12)
            query.findObjectsInBackground { object, error in
                withAnimation {
                    self.islogin = true
                }
                 if error != nil{
                     print("获取失败")
                 }else{
                     for i in count..<count + object!.count {
                         // 获取基本信息
                         guard count + object!.count - 1 < object!.count else {
                             print("10088\(object!.count)")
                             return}
                         
                         let item = object![i]
                         let objectid = item.object(forKey: "userobjectId") as! String
                         let title = item.object(forKey: "title") as! String
                         let content = item.object(forKey: "content") as! String
                         let locate = item.object(forKey: "locate") as! String
                         let publishtime = item.createdAt!
                         let pyqobjectid =  item.objectId!
                         let love = item.object(forKey: "love") as! Int
                         let star = item.object(forKey: "star") as! Int
                         let query2 = PFQuery(className: "Pyqimages")
                         query2.whereKey("title", equalTo: title)
                         query2.whereKey("content", equalTo:content)
                         query2.whereKey("userobjectid", equalTo:objectid)
                         query2.findObjectsInBackground { imageobject, error in
                             var imageurl : [String] = []
                             if imageobject?.count != 0{
                                 for i in imageobject!{
                                     let img = i["image"] as! PFFileObject
                                     imageurl.append(img.url!)
                                 }
                             }
                             
                             let query = PFQuery(className: "PinLun")
                             query.whereKey("PublishContent", equalTo: content)
                             query.whereKey("Publisherobjectid", equalTo: objectid)
                             query.findObjectsInBackground { object, error in
                                 var pinlun : [MyPinlun] = []
                                 if object?.count != 0{
                                     for i in object!{
                                         let objectname = i.object(forKey: "objectname") as! String // 自己的名字
                                         let pinlunname = i.object(forKey: "pinlunname") as! String // 对象的名字
                                         let objectimageurl = i.object(forKey: "objectimageurl") as! String
                                         let love = i.object(forKey: "love") as! Int
                                         let content2 = i.object(forKey: "pinlun") as! String
                                         let content = i.object(forKey: "content") as! String
                                         let pinluncontent =  i.object(forKey: "PinLunContent") as! String
                                         let time = i.createdAt!
                                         pinlun.append(MyPinlun(objectname: objectname, pinlunname: pinlunname, objectimageurl: objectimageurl,content:content,pinlun:content2, love: love,pinluncontent:pinluncontent, pinluntime: time))
                                                                  print("pinlun.count\(pinlun.count)")
                                     }
                                 }
                                 
                                 let query3 = PFUser.query()
                                 query3?.whereKey("username", equalTo: objectid)
                                 query3?.getFirstObjectInBackground(block: { user, error in
                                     var cardclient = Client(username: "", clientname: "", introduction: "", sex: "", locate: "", clientimage: "", clientbackground: "", birthday: Date(), school: "")
                                     if user != nil{
                                         withAnimation {
                                             let username = user!.objectId!
                                             let clientname = user!.object(forKey: "username") as! String
                                             let introduce = user!.object(forKey: "introduction") as! String
                                             let sex = user!.object(forKey: "sex") as! String
                                             let locate = user!.object(forKey: "locate") as! String
                                             let clientimage = user!["clientimage"] as! PFFileObject
                                             let backgrounimage = user!["clientbackground"] as! PFFileObject
                                             let school = user!.object(forKey: "school") as! String
                                             let brithday = user!.object(forKey: "birthday") as! Date
                                             cardclient = Client(username: username, clientname: clientname, introduction: introduce, sex:sex, locate: locate, clientimage: clientimage.url!, clientbackground: backgrounimage.url!,birthday: brithday,school: school)
                                         }
                                     }
                                     DispatchQueue.main.async {
                                         withAnimation {
                                             self.allPyqData.append(Carddata(title: title, content: content, locate: locate, publishtime: publishtime,publishimageurl: imageurl, pinlun:pinlun,love:love,star:star,pyqobjectid :pyqobjectid,client:cardclient))
                                         }
                                     }
                                 })
                             }
                        }
                                                
                     }
                 }
             }
        }
    }
    
    
   
}

struct MyPinlun : Identifiable,Codable,Equatable{
    var id =  UUID()
    var objectname : String // 自己的名字
    var pinlunname : String // 回复谁的
    var objectimageurl : String
    var content : String // 回复哪一句话的
    var pinlun : String // 回复的内
    var love : Int
    var pinluncontent : String
    var pinluntime : Date
}
