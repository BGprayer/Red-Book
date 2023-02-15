//
//  install.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/23.
//

import SwiftUI

struct install: View {
    @Environment(\.presentationMode) var presentationMode
    @State var logout = false
    @AppStorage("islogin") var islogin = false
    var body: some View {
        NavigationView{
            List{
                Section{
                    NavigationLink{
                        
                    }label: {
                        Text("账号与安全")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("隐私设置")
                    }
                }
                
                Section{
                    NavigationLink{
                        
                    }label: {
                        Text("通知设置")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("通用设置")
                    }
                }
                
                Section{
                    NavigationLink{
                        
                    }label: {
                        Text("青少年模式")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("深色模式")
                    }
                    
                    NavigationLink{
                        
                    }label: {
                        Text("字体大小")
                    }
                }
                
                Section{
                    NavigationLink{
                        
                    }label: {
                        Text("帮助与客服")
                    }
                    NavigationLink{
                        
                    }label: {
                        Text("鼓励一下")
                    }
                    
                    NavigationLink{
                        
                    }label: {
                        Text("关于本App")
                    }
                }
                Button{
                    withAnimation{
                        logout = true
                    }
                }label: {
                    HStack{
                        Spacer()
                        Text("退出账号")
                        Spacer()
                    }
                }
                .foregroundColor(.black)
            }
            .alert(isPresented: $logout) {
                Alert(title: Text("确定要退出吗?"), message: Text(""), primaryButton: Alert.Button.cancel(Text("取消"),action: {
                    logout = false
                }), secondaryButton: Alert.Button.default(Text("确定"),action: {
                    withAnimation {
                        logout = false
                        UserDefaults.standard.removeObject(forKey: "MyClient")
                        islogin = false
                    }
                }))
            }
            .navigationTitle("设置")
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
    }
}

struct install_Previews: PreviewProvider {
    static var previews: some View {
        install()
    }
}
