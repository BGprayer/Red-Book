//
//  CardDetial.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/11.
//

import SwiftUI
import Parse

struct CardDetial: View {
    @EnvironmentObject var Myclientdata  : ClientData
    @State var card : Carddata
    @EnvironmentObject var mynotdata : NoticeData
    @EnvironmentObject var pyqdata : PYQData
    @Environment(\.presentationMode) var presentationMode
    var index : Int
//    var namespace : Namespace.ID
    @State var Mypinlun = ""
    @State var isLoved : Bool = false
    @State var isStared : Bool   = false
    @State var  IsConcern : Bool = false
    @State var showalert : Bool = false
    @State var pinlunname : String = ""
    @State var pinluncontent : String = ""
    @State var content : String = ""
    
    
    func isloved(){
        let query = PFQuery(className: "Love")
        query.whereKey("myobjectid", equalTo: Myclientdata.MyClient.username)
        query.whereKey("pyqobjectid", equalTo: card.pyqobjectid)
        query.whereKey("Isshow", equalTo: true)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                isLoved = true
            }
        }
    }
    
    func isconcern(){
        let query = PFQuery(className: "ConcernAndFans")
        query.whereKey("Myobjectid", equalTo: Myclientdata.MyClient.username)
        query.whereKey("objectid", equalTo: card.client.username)
        query.whereKey("Isshow", equalTo: true)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                IsConcern = true
            }
        }
    }
    
    func isStar(){
        let query = PFQuery(className: "Star")
        query.whereKey("myobjectid", equalTo: Myclientdata.MyClient.username)
        query.whereKey("pyqobjectid", equalTo: card.pyqobjectid)
        query.whereKey("Isshow", equalTo: true)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                isStared = true
            }
        }
    }
    
    func UploadLove(){
        let object = PFObject(className: "Love")
        object["myobjectid"] = Myclientdata.MyClient.username
        object["objectid"] = card.client.clientname
        object["pyqobjectid"] = card.pyqobjectid
        object["pyqcontent"] = card.content
        object["pyqimage"] = card.publishimageurl.first!
        object["Isshow"] = true
        object.saveInBackground()
        // 保存下来之后 保存到本地来
        let query2 = PFQuery(className: "Card")
        query2.whereKey("objectId", equalTo: card.pyqobjectid)
        query2.getFirstObjectInBackground { obj, error in
            if obj != nil{
                var love = obj!["love"] as! Int
                love += 1
                obj!["love"] = love
                obj!.saveInBackground()
            }
        }
        self.mynotdata.LoveMyself.append(card)
    }
    
    func DeleteLove(){
        let query = PFQuery(className:"Love")
        query.whereKey("myobjectid", equalTo:Myclientdata.MyClient.username)
        query.whereKey("pyqobjectid", equalTo:card.pyqobjectid)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                obj!["Isshow"] = false
                obj!.saveInBackground()
            }
        }
        let query2 = PFQuery(className: "Card")
        query2.whereKey("objectId", equalTo: card.pyqobjectid)
        query2.getFirstObjectInBackground { obj, error in
            if obj != nil{
                var love = obj!["love"] as! Int
                love -= 1
                obj!["love"] = love
                obj!.saveInBackground()
            }
        }
        // 保存下来之后 保存到本地来
        self.mynotdata.LoveMyself.removeAll{$0.pyqobjectid == card.pyqobjectid}
    }
    
    func UploadStar(){
        let object = PFObject(className: "Star")
        object["myobjectid"] = Myclientdata.MyClient.username
        object["objectid"] = card.client.clientname
        object["pyqobjectid"] = card.pyqobjectid
        object["pyqcontent"] = card.content
        object["pyqimage"] = card.publishimageurl.first!
        object["Isshow"] = true
        object.saveInBackground()
        let query = PFQuery(className: "Card")
        query.whereKey("objectId", equalTo: card.pyqobjectid)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                var star = obj!["star"] as! Int
                star += 1
                obj!["star"] = star
                obj!.saveInBackground()
            }
        }
        // 保存下来之后 保存到本地来
        self.mynotdata.starMyself.append(card)
    }
    
    func DeleteStar(){
        let query = PFQuery(className:"Star")
        query.whereKey("myobjectid", equalTo:Myclientdata.MyClient.username)
        query.whereKey("pyqobjectid", equalTo:card.pyqobjectid)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                obj!["Isshow"] = false
                obj!.saveInBackground()
            }
        }
        
        let query2 = PFQuery(className: "Card")
        query2.whereKey("objectId", equalTo: card.pyqobjectid)
        query2.getFirstObjectInBackground { obj, error in
            if obj != nil{
                var star = obj!["star"] as! Int
                star -= 1
                obj!["star"] = star
                obj!.saveInBackground()
            }
        }
        // 保存下来之后 保存到本地来
        self.mynotdata.starMyself.removeAll{$0.pyqobjectid == card.pyqobjectid}
    }
    
    func AddConcern(){
        let object = PFObject(className: "ConcernAndFans")
        object["Myobjectid"] = Myclientdata.MyClient.username
        object["objectid"] = card.client.clientname
        object["Isshow"] = true
        object.saveInBackground()
    }
    
    func DeleteConcern(){
        let query = PFQuery(className: "ConcernAndFans")
        query.whereKey("Myobjectid", equalTo: Myclientdata.MyClient.username)
        query.whereKey("objectid", equalTo: card.client.clientname)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                obj!["Isshow"] = false
                obj!.saveInBackground()
            }
        }
    }
    
    func UploadMyPinLun(pinluns:MyPinlun,Publisherobjectid:String,PublishContent:String){
        self.card.pinlun.append(pinluns)
        pyqdata.allPyqData[index].pinlun.append(pinluns)
        pyqdata.datastore()
        let pinlun = PFObject(className: "PinLun")
        pinlun["content"] = pinluns.content
        pinlun["Publisherobjectid"] = Publisherobjectid
        pinlun["objectname"] = pinluns.objectname
        pinlun["pinlunname"] = pinluns.pinlunname
        pinlun["objectimageurl"] = pinluns.objectimageurl
        pinlun["love"]  = pinluns.love
        pinlun["pinlun"] = pinluns.pinlun
        pinlun["PublishContent"] = PublishContent
        pinlun["PinLunContent"] = pinluns.pinluncontent
        pinlun.saveInBackground()
    }
    
    var body: some View {
            VStack{
                //顶部
                HStack{
                HStack{
                    Button{
                        withAnimation(.spring(response: 0.2, dampingFraction:0.8)){
                                presentationMode.wrappedValue.dismiss()
                        }
                    }label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                    }
                    PublicURLImageView(imageurl:card.client.clientimage, contentmode: true)
                            .mask(Circle())
                            .frame(width: 40, height: 40)
                    Text(card.client.clientname)
                    Spacer()
                    
                    if card.client.username != Myclientdata.MyClient.username{
                        HStack(spacing: 15){
                            if IsConcern{
                                Button{
                                    showalert = true
                                }label: {
                                    Text("已关注")
                                        .foregroundColor(.gray)
                                        .padding(.vertical,5)
                                        .padding(.horizontal,18)
                                        .background(.white)
                                        .padding(1)
                                        .background(.pink,in : RoundedRectangle(cornerRadius: 20))
                                }
                            }
                            else{
                                Button{
                                    IsConcern.toggle()
                                    AddConcern()
                                }label: {
                                    Text("关注")
                                        .foregroundColor(.pink)
                                        .padding(.vertical,5)
                                        .padding(.horizontal,18)
                                        .background(.white)
                                        .padding(1)
                                        .background(.pink,in : RoundedRectangle(cornerRadius: 20))
                                }
                            }
                        }
                        Image(systemName: "square.and.arrow.up").font(.system(size: 25))
                    }
                }
                .padding(.horizontal)
                .transition(.opacity)
                    
                }
                ScrollView{  //主页
                    
                    TabView{
                        ForEach(Array(card.publishimageurl.enumerated()),id: \.offset){ count,img in
                            PublicURLImageView(imageurl:img, contentmode: false)
                                .tag(count)
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height:500)
                    
                    VStack(spacing:20){
                        HStack{
                            VStack(alignment:.leading){

                                Text(card.title)
                                    .font(.title)
                                Divider()
                                Text(card.content)
                            }
                            Spacer()
                        }
                        
                        HStack{
                            HStack{
                                Text(card.publishtime.formatted())
                                Text(card.locate)
                            }
                            Spacer()
                            
                            
                            Button{
                                
                            }label: {
                                HStack{
                                    Image(systemName: "face.smiling")
                                    Text("不喜欢")
                                }
                                .padding(3)
                                .background(.white)
                                .padding(1)
                                .background(.gray,in:RoundedRectangle(cornerRadius: 20))
                            }
                        }
                        .foregroundColor(.gray)
                        
                    }
                    .padding(.horizontal)
                    .transition(.opacity)
                    
                    Divider()
                    
                    if card.pinlun.count != 0{
                        VStack{
                            HStack{
                                Text("共")+Text("\(card.pinlun.count)")+Text("条评论")
                                Spacer()
                            }
                            .foregroundColor(.gray)
                            .padding(.horizontal)

                            HStack{
                                PublicURLImageView(imageurl:Myclientdata.MyClient.clientimage, contentmode: true)
                                        .mask(Circle())
                                        .frame(width: 40, height: 40)

                                TextField("喜欢就给个评论支持一下", text: $Mypinlun)
                                    .padding(.vertical,6)
                                    .padding(.horizontal,10)
                                    .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 20))

                                Spacer()
                            }
                            .padding(.horizontal)

                            PinLunDetial(card:card,pinlunname: $pinlunname,pinluncontent: $pinluncontent,content :$content)
                        }
                        .transition(.opacity)
                    }
                    else{
                        Text("----还没有人评论哦----")
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .transition(.opacity)
                           
                    }
                }
                    
                //底部
                HStack{
                    TextField("回复\(pinlunname)的\(content):", text: $Mypinlun)
                        .padding(.horizontal,10)
                        .padding(.vertical,6)
                        .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 20))
                    
                    Button{
                        if Mypinlun != ""{
                        if content == ""{
                            content = card.content
                            pinluncontent = card.content
                        }
                        if pinlunname == ""{
                            pinlunname =  card.client.clientname
                        }
                            UploadMyPinLun(pinluns: MyPinlun(objectname:Myclientdata.MyClient.clientname, pinlunname: pinlunname, objectimageurl: Myclientdata.MyClient.clientimage, content:content, pinlun: Mypinlun, love: 0,pinluncontent: pinluncontent, pinluntime: Date()), Publisherobjectid: card.client.clientname, PublishContent: card.content)
                        pinlunname = ""
                        content = ""
                        Mypinlun = ""
                        pinluncontent = ""
                        }
                    }label: {
                       
                        Image(systemName: "location.north")
                            .foregroundColor(.black)
                    }
                    
                    HStack(spacing:10){
                        HStack(spacing:0){
                            if isLoved{
                                Button{
                                    isLoved.toggle()
                                    card.love -= 1
                                    DeleteLove()
                                }label: {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 18))
                                }
                            }else{
                                Button{
                                    isLoved.toggle()
                                    card.love += 1
                                   UploadLove()
                                }label: {
                                    Image(systemName: "heart")
                                        .font(.system(size: 18))
                                }
                            }
                            
                            Text("\(card.love)")
                        }
                        
                        HStack(spacing:0){
                            
                            if isStared{
                                Button{
                                    isStared.toggle()
                                    card.star -= 1
                                    DeleteStar()
                                }label: {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 18))
                                }
                            }else{
                                Button{
                                    isStared.toggle()
                                    card.star += 1
                                    UploadStar()
                                }label: {
                                    Image(systemName: "star")
                                        .font(.system(size: 18))
                                }
                            }
                            Text("\(card.star)")
                        }
                        
                        HStack(spacing:0){
                            Button{
                                
                            }label: {
                                Image(systemName: "ellipsis.bubble")
                                    .font(.system(size: 18))
                            }
                            
                            Text("\(card.pinlun.count)")
                        }
                    }
                    .foregroundColor(.black)
                }// tabbar
                    .padding(.horizontal)
                    .transition(.opacity)
            }
//            .padding(.top,50)
//            .padding(.bottom,30)
                // shadow
            .background(.white)
            .onAppear(perform: {
                isloved()
                isStar()
                isconcern()
              
            })
            .alert(isPresented: $showalert) {
                Alert(title: Text("确定要取消关注吗?"), message: Text(""), dismissButton: Alert.Button.cancel(Text("确定"),action: {
                    IsConcern.toggle()
                    DeleteConcern()
            }))
            }
    }
}


