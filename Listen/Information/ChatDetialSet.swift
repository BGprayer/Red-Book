//
//  ChatDetialSet.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/23.
//

import SwiftUI

struct ChatDetialSet: View {
    @Environment(\.presentationMode) var presentationMode
    @State var IsOn1 = false
    @State var IsOn2 = false
    @State var IsOn3 = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Color.clear.frame(height: 90)
                    HStack{
                        Image("IMG_6417")
                            .CircleImage(width: 70)
                        Text("username")
                        Spacer()
                        
                        Button{
                            
                        }label: {
                            Text("关注")
                                .foregroundColor(.white)
                                .padding(.vertical,5)
                                .padding(.horizontal,30)
                                .background(.pink,in: RoundedRectangle(cornerRadius: 20))
                                .padding(.trailing)
                        }
                    }
                }
                .background(.white)
                
                
                VStack(spacing:15){
                    Toggle("消息免打扰", isOn: $IsOn1)
                        .toggleStyle(SwitchToggleStyle(tint: Color.pink))
                        
                    Divider()
                    Toggle("置顶聊天", isOn: $IsOn2)
                        .tint(.pink)
                }
                .tint(Color("red"))
                .padding(10)
                .background(.white)
                
                VStack(spacing:15){
                    Toggle("屏蔽消息", isOn: $IsOn3)
                        .tint(.pink)
                    Divider()
                    NavigationLink{
                        
                    }label: {
                        HStack{
                            Text("举报该用户")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom,5)
                    }
                }
                .foregroundColor(.black)
                .padding(10)
                .background(.white)
                
                HStack{
                    Text("清空聊天记录")
                    Spacer()
                }
                .foregroundColor(.black)
                .padding(.vertical)
                .padding(.horizontal,10)
                .background(.white)
                
            }
            .ignoresSafeArea()
            .background(.gray.opacity(0.2))
            .navigationTitle("聊天设置")
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

struct ChatDetialSet_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetialSet()
    }
}
