//
//  ClientDetialView.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/22.
//

import SwiftUI

struct ClientDetialView2: View {
    @EnvironmentObject var Myclientdata  : ClientData
    @State var ShowImagePicker = false
    @State var backgrounddata = Data()
    
    func string(from data: Data) -> String {
            return String(format: "%@", data as CVarArg)
    }
    var body: some View {
        VStack{
            VStack{
                NavigationLink{
                    EditIngView1(username:Myclientdata.MyClient.clientname)
                        .navigationBarHidden(true)
                }label: {
                    HStack{
                        Text("名字")
                        Spacer()
                        Text(Myclientdata.MyClient.clientname)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                Divider()
                
                
                HStack{
                        Text("账号")
                        Spacer()
                        Text(Myclientdata.MyClient.username)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                Divider()
                
                NavigationLink{
                    EditIngView2(introduction:Myclientdata.MyClient.introduction)
                        .navigationBarHidden(true)
                }label: {
                    HStack{
                        Text("简介")
                        Spacer()
                        Text(Myclientdata.MyClient.introduction)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                Divider()
            }
        VStack{
                NavigationLink{
                    EditIngView3(sex:Myclientdata.MyClient.sex)
                        .navigationBarHidden(true)
                }label: {
                    HStack{
                        Text("性别")
                        Spacer()
                        Text(Myclientdata.MyClient.sex)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(.horizontal,10)
                    .background(.white)
                }
                Divider()
                
                NavigationLink{
                    EditIngView4(newbirthday:Myclientdata.MyClient.birthday)
                        .navigationBarHidden(true)
                }label: {
                    HStack{
                        Text("生日")
                        Spacer()
                        Text(DateFormmatter2(date:Myclientdata.MyClient.birthday))
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                Divider()
                
            NavigationLink{
                EditIngView5(locate:Myclientdata.MyClient.locate)
                    .navigationBarHidden(true)
            }label: {
                HStack{
                    Text("地区")
                    Spacer()
                    Text(Myclientdata.MyClient.locate)
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.gray)
                .padding(10)
                .background(.white)
            }
            Divider()
        }
        VStack{
            NavigationLink{
                EditIngView6(school:Myclientdata.MyClient.school)
                    .navigationBarHidden(true)
            }label: {
                HStack{
                    Text("学校")
                    Spacer()
                    Text(Myclientdata.MyClient.school)
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.gray)
                .padding(10)
                .background(.white)
            }
            Divider()
            
                Button{
                    self.ShowImagePicker = true
                }label: {
                    HStack{
                        Text("背景图")
                        Spacer()
                        PublicURLImageView(imageurl: Myclientdata.MyClient.clientbackground, contentmode: true)
                         .frame(width: 50, height:50)
                         .clipped()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                }
                Divider()
        }
    }
        .fullScreenCover(isPresented: $ShowImagePicker){
            if (!backgrounddata.isEmpty){
//                Myclientdata.MyClient.clientbackground = string(from: backgrounddata)
//                Myclientdata.datastore()
                Myclientdata.ServerSaveImage(ChangeName: "clientbackground", ChangeContent: backgrounddata)
            }
        } content: {
            PublicImagePicker(completeHandler: { image in
                guard image.first?.imagedata != nil else {return}
                self.backgrounddata = image.first!.imagedata!
            },ChoiceMode: false)
        }
    }
}

struct ClientDetialView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var Myclientdata  : ClientData
    @State var ShowImagePicker = false
    @State var Imagedata = Data()
    func string(from data: Data) -> String {
            return String(format: "%@", data as CVarArg)
    }
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:25){
                    HStack{
                        Spacer()
                        Button{
                            self.ShowImagePicker = true
                        }label: {
                            PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
                            .mask(Circle())
                            .frame(width: 100, height: 100)
                            .clipped()
                            .overlay(
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        Image(systemName: "camera.fill")
                                            .foregroundColor(.black)
                                            .padding(5)
                                            .background(.gray,in:Circle())
                                            .padding(.top)
                                    }
                                }
                            )
                            .padding(.top,15)
                        }
                        Spacer()
                    }
                    ClientDetialView2()
                }
            }
            .background(.white)
            .navigationTitle("编辑资料")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .fullScreenCover(isPresented: $ShowImagePicker){
            if (!Imagedata.isEmpty){
//                Myclientdata.MyClient.clientimage = string(from: Imagedata)
//                Myclientdata.datastore()
                Myclientdata.ServerSaveImage(ChangeName: "clientimage", ChangeContent: Imagedata)
            }
        }content:{
            PublicImagePicker(completeHandler: { image in
                guard image.first?.imagedata != nil else {return}
                self.Imagedata = image.first!.imagedata!
            },ChoiceMode: false)
        }
        .alert(isPresented: $Myclientdata.saveresult) {
            Alert(title: Text("修改成功!"), message: Text(""), primaryButton: Alert.Button.cancel(Text("确定"),action: {
                Myclientdata.saveresult = false
            }), secondaryButton: Alert.Button.default(Text("取消"),action: {
                Myclientdata.saveresult = false
            }))
        }
    }
}

struct ClientDetialView_Previews: PreviewProvider {
    static var previews: some View {
        ClientDetialView()
    }
}
