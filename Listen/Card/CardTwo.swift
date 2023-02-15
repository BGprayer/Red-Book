//
//  CardTwo.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/12.
//

import SwiftUI
import Parse
struct CardTwo: View {
    @State var index : Int = 0
    @State var card : Carddata
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var pyqdata : PYQData
    @EnvironmentObject var mycarddatas : Model
    @State var text = ""
    @Binding var showContend : Bool
    @Binding var showaccountdetial : Bool
    @State var LoveInt : Int = 0
    @State var StarInt : Int = 0
    @State var isLoved : Bool = false
    @State var isStared : Bool   = false
    @State var  IsConcern : Bool = false
    @State var pinlunname : String = ""
    @State var pinluncontent : String = ""
    @State var content : String = ""
    
    
    func GetIndex(){
        for i in 0..<pyqdata.allPyqData.count{
            if pyqdata.allPyqData[i] == card{
                self.index = i
                print("\(index)index")
                return
            }
        }
    }
    
//    func UploadLove(mode:String){
//        let query = PFUser.query()
//        query?.whereKey("objectId", equalTo: Myclientdata.MyClient.username)
//        query?.getFirstObjectInBackground(block: { obj, error in
//            if obj != nil{
//                var love = obj!.object(forKey: "love") as! [String]
//                if mode == "add"{
//                    self.Myclientdata.MyClient.love.append(card.pyqobjectid)
//                    Myclientdata.datastore()
//                    love.append(card.pyqobjectid)
//                    obj!["love"] = love
//                    obj!.saveInBackground()
//                }else{
//                    self.Myclientdata.MyClient.love.removeAll{$0 == card.pyqobjectid}
//                    Myclientdata.datastore()
//                    love.removeAll {$0 == card.pyqobjectid}
//                    obj!["love"] = love
//                    obj!.saveInBackground()
//                }
//            }
//        })
//    }
    
//    func IsLove(){
//        for i in Myclientdata.MyClient.love{
//            if i  == card.pyqobjectid{
//                self.isLoved = true
//            }
//        }
//    }
//
//    func IsStar(){
//        for i in Myclientdata.MyClient.star{
//            if i  == card.pyqobjectid{
//                self.isStared = true
//            }
//        }
//    }
    
    func GetLoveInt(){
        let query = PFUser.query()
        query?.whereKey("love", contains:card.pyqobjectid)
        query?.findObjectsInBackground(block: { obj, error in
            if obj != nil{
                self.LoveInt = obj!.count
            }
        })
    }

    func GetStarInt(){
        let query = PFUser.query()
        query?.whereKey("star", contains:card.pyqobjectid)
        query?.findObjectsInBackground(block: { obj, error in
            if obj != nil{
                self.StarInt = obj!.count
            }
        })
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
            HStack{
                //头像
                NavigationLink{
                    ConcernAccountDetial(otherclient: card.client, showaccountdetial: $showaccountdetial)
                        .navigationBarHidden(true)
                        
                }label: {
                    PublicURLImageView(imageurl: card.client.clientimage, contentmode: true)
                        .mask(Circle())
                        .frame(width: 40, height: 40)
                }
                
                Text(card.client.clientname)
                HStack(spacing:0){
                    Text(GetTime(date: card.publishtime))
                    Text("前")
                }
                .font(.footnote)
                .foregroundColor(.gray)
                Spacer()
                
                Button{
                    withAnimation {
                        mycarddatas.myselectobjectid = card.client.username
                        showaccountdetial = true
                    }
                }label: {
                    Image(systemName: "ellipsis")
                }
            }
            .foregroundColor(.black)
            .padding(.trailing,8)
            
            TabView{
                ForEach(card.publishimageurl){ item in
                    PublicURLImageView(imageurl: item, contentmode: false)
                        .tag(item)
                }
            }
            .tabViewStyle(.page)
            .frame(height:500)
            
            HStack(spacing:14){
                //社交功能
                
                Button{
                    
                }label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 20))
                }
                Spacer()
                if isLoved{
                    Button{
                        isLoved.toggle()
                        LoveInt -= 1
//                        UploadLove(mode: "delete")
                    }label: {
                        HStack(spacing:0){
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 22))
                            Text("\(LoveInt)")
                        }
                    }
                }else{
                    Button{
                        isLoved.toggle()
                        LoveInt += 1
//                        UploadLove(mode: "add")
                    }label: {
                        HStack(spacing:0){
                            Image(systemName: "heart")
                                .font(.system(size: 22))
                            Text("\(LoveInt)")
                        }
                    }
                }
                
                if isStared{
                    Button{
                        isStared.toggle()
                        StarInt -= 1
//                        UploadStar(mode: "delete")
                    }label: {
                        HStack(spacing:0){
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 22))
                            Text("\(StarInt)")
                        }
                    }
                }else{
                    Button{
                        isStared.toggle()
                        StarInt -= 1
//                        UploadStar(mode: "add")
                    }label: {
                        HStack(spacing:0){
                        Image(systemName: "star")
                            .font(.system(size: 22))
                            Text("\(StarInt)")
                        }
                    }
                }
                
                Button{
                    withAnimation{
                        GetIndex()
                        mycarddatas.selection = self.index
                        showContend = true
                    }
                }label: {
                    HStack(spacing:0){
                        Image(systemName: "ellipsis.bubble")
                            .font(.system(size: 20))
                        
                        Text("\(card.pinlun.count)")
                    }
                }
                .sheet(isPresented: $showContend){
                    CardTwoDetial(index: self.$index, card: card, showContend: $showContend)
                }
                
            }
            .foregroundColor(.black)
            .padding(10)
            
            HStack{
                //内容
                Text(card.content)
                Spacer()
            }
            .padding()
            
            HStack{
                //评论
                PublicURLImageView(imageurl:Myclientdata.MyClient.clientimage , contentmode: true)
                    .mask(Circle())
                    .frame(width: 40, height: 40)
                TextField("喜欢就给个评论吧",text: $text)
                
                Button{
                    if text != ""{
                        UploadMyPinLun(pinluns: MyPinlun(objectname:Myclientdata.MyClient.clientname, pinlunname: "", objectimageurl: Myclientdata.MyClient.clientimage, content:card.content, pinlun: text, love: 0,pinluncontent: "", pinluntime: Date()), Publisherobjectid: card.client.username, PublishContent: card.content)
                    }
                    text = ""
                }label: {
                    Image(systemName: "location.north")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(5)
            .background(.gray.opacity(0.1),in:RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal,8)
            
            Divider()
        }
        .padding(.vertical)
    }
}


