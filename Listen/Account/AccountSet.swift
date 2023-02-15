//
//  AccountSet.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/21.
//

import SwiftUI

struct AccountSet: View {
    var body: some View {
        VStack(spacing:0){
            ScrollView{
                VStack(alignment: .leading, spacing: 20){
                    Label("发现好友",systemImage: "person.badge.plus")
                    Divider()
                    Label("创作中心",systemImage: "person.badge.plus")
                    Label("我的草稿",systemImage: "person.badge.plus")
                    Label("浏览记录",systemImage: "person.badge.plus")
                    Divider()
                    Label("公约",systemImage: "person.badge.plus")
                    
                }
                .font(.system(size: 20))
                .padding(.leading,30)
            }
            .frame(height:UIScreen.main.bounds.height - 200)
            
            HStack{
                Spacer()
                NavigationLink{
                    install()
                        .navigationBarHidden(true)
                }label: {
                    VStack{
                        Image(systemName: "gearshape")
                            .padding(10)
                            .background(.gray.opacity(0.2),in:Circle())
                        Text("设置")
                    }
                    .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .frame(width:UIScreen.main.bounds.width * 2 / 3,height: UIScreen.main.bounds.height)
        .background(.white)
    }
}

struct AccountSet_Previews: PreviewProvider {
    static var previews: some View {
        AccountSet()
    }
}
