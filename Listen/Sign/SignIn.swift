//
//  SignIn.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/27.
//

import SwiftUI
import Parse

struct SignIn: View {
    @State var username = ""
    @State var password = ""
    @State var success = false
    @State var signupMode = false
    @AppStorage("islogin") var islogin = false
    @State var isprogress = false
    @State var ishover = false
    @EnvironmentObject var Mycilentdata : ClientData
    
    func SignUp(username:String,password:String){
        var user = PFUser()
        user.username = username
        user.password = password
        user["clientname"] = "1"
        user["introduction"] = ""
        user["sex"] = "未知"
        user["locate"] = "中国大陆"
        let image = UIImage(named: "image3")!
        let imagedata = image.pngData()!
        user["clientimage"] = PFFileObject(name: "image.png", data: imagedata)!
        user["clientbackground"] = PFFileObject(name: "image.png", data: imagedata)!
        user["school"] = "未知"
        user["birthday"] = Date()
//        user["profession"] = "未知"
        user["concern"] = []
        user["fans"] = []
        user["love"] = []
        user["star"] = []
        user.signUpInBackground{ success,error in
            if(error == nil){
                print("注册成功")
                self.success = true
                print(self.success)
            }
        }
    }
    
    func setNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (isallow,error) in
            if !isallow{
                print("用户不同意通知")
            }else{
                print("用户同意通知")
            }
        }
    }
    
    func SignIn(username:String,password:String){
        PFUser.logInWithUsername(inBackground: username, password: password){ user, error in
            if(user != nil){
                withAnimation{
                    print("登陆成功")
                    let username = user!.object(forKey: "username") as! String
                    let clientname = user!.object(forKey: "clientname") as! String
                    let introduction = user!.object(forKey: "introduction") as! String
                    let sex = user!.object(forKey: "sex") as! String
                    let locate = user!.object(forKey: "locate") as! String
                    let clientimage = user!["clientimage"] as! PFFileObject
                    
                    let clientbackground = user!["clientbackground"] as! PFFileObject
                    
                    let birthday = user!.object(forKey: "birthday") as! Date
                    
                    let school = user!.object(forKey: "school") as! String
                    
                    Mycilentdata.MyClient = Client(username: username, clientname: clientname, introduction: introduction, sex: sex, locate: locate, clientimage: clientimage.url!, clientbackground: clientbackground.url!,birthday:birthday,school: school)
                    Mycilentdata.datastore()
                    setNotification()
                    islogin = true
                }
            }
            else{
                withAnimation {
                    isprogress = false
                }
            }
        }
    }
    var body: some View {
        ZStack{
        VStack{
            HStack{
                Spacer()
                Text("帮助")
            }
            .foregroundColor(.gray)
            .padding()
            
            Color.clear.frame(height:180)
            
            ZStack{
                VStack(spacing:20){
                    HStack{
                        Text("用户")
                        TextField("填写用户名",text: $username)
                    }
                    Divider()
                    HStack{
                        Text("密码")
                        SecureField("填写密码",text: $password)
                    }
                    Divider()
                    Button{
                        withAnimation {
                            isprogress = true
                        }
                        SignUp(username: username, password: password)
                    }label: {
                        Text("注册")
                            .frame(width:UIScreen.main.bounds.width / 4 - 10,height: 40)
                            .foregroundColor(.white)
                            .background(.blue,in:RoundedRectangle(cornerRadius: 10))
                            .padding(10)
                    }
                    Button{
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                            username = ""
                            password = ""
                            signupMode = false
                        }
                    }label: {
                        HStack{
                            Text("注册成功，点击登录")
                                .foregroundColor(.gray)
                                .font(.footnote)
                            Spacer()
                        }
                    }
                }
                .frame(width:UIScreen.main.bounds.width - 120)
                .padding()
                .background(.ultraThinMaterial,in:RoundedRectangle(cornerRadius: 20))
                .padding()
                .shadow(color: .gray.opacity(0.3), radius: 30, x: 0, y: 30)
                .rotation3DEffect(.degrees(signupMode ? 0:180), axis: (x:0, y:-10, z: 0))
                .opacity(signupMode ? 1:0)
            VStack(spacing:20){
                HStack{
                    Text("用户")
                    TextField("填写用户名",text: $username)
                }
                Divider()
                HStack{
                    Text("密码")
                    SecureField("填写密码",text: $password)
                }
                Divider()
                Button{
                    withAnimation {
                        isprogress = true
                    }
                    SignIn(username: username, password: password)
                }label: {
                    Text("登陆")
                        .frame(width:UIScreen.main.bounds.width / 4 - 10,height: 40)
                        .foregroundColor(.white)
                        .background(.pink,in:RoundedRectangle(cornerRadius: 10))
                        .padding(10)
                }
                Button{
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
                        username = ""
                        password = ""
                        signupMode = true
                    }
                }label: {
                    HStack{
                        Text("还没有账户？点击注册")
                            .foregroundColor(.gray)
                            .font(.footnote)
                        Spacer()
                    }
                }
            }
            .frame(width:UIScreen.main.bounds.width - 120)
            .padding()
            .background(.ultraThinMaterial,in:RoundedRectangle(cornerRadius: 20))
            .padding()
            .shadow(color: .gray.opacity(0.3), radius: 30, x: 0, y: 30)
            .rotation3DEffect(.degrees(signupMode ? 180:0), axis: (x:0, y:10, z: 0))
            .opacity(signupMode ? 0:1)
            }
            .shadow(color: ishover ? .gray.opacity(0.3):.gray.opacity(0), radius:30, x: 0, y: 20)
            .onTapGesture {
                withAnimation {
                    self.ishover = true
                }
            }
            Spacer()
            
            Button{
                withAnimation {
                    signupMode = true
                }
            }label: {
                HStack{
                    Text("其他方式登陆")
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundColor(.gray)
            .font(.footnote)
        }
            if isprogress{
                ZStack{
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView()
                        .foregroundColor(.white)
                        .scaleEffect(2)
                }
            }
    }
        .onChange(of: success, perform: { newValue in
            if newValue == true{
                withAnimation {
                    isprogress = false
                }
            }
        })
        .onChange(of: islogin, perform: { newValue in
            if newValue == true{
                withAnimation {
                    isprogress = false
                }
            }
        })
        .alert(isPresented: $success) {
            Alert(title: Text("注册成功"), message: Text(""), dismissButton: Alert.Button.cancel(Text("确定")))
        }
        .alert(isPresented: $islogin) {
            Alert(title: Text("登陆成功"), message: Text(""), dismissButton: Alert.Button.cancel(Text("确定")))
        }

    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
            .environmentObject(ClientData(FromOutMyClient: initMyClientData()))
    }
}
