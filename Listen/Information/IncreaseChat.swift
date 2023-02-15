//
//  IncreaseChat.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/23.
//

import SwiftUI

struct IncreaseChat: View {
    @Environment(\.presentationMode) var presentationMode
        @State var searchtext = ""
        var body: some View {
            VStack{
                VStack{
                    HStack{
                        Button{
                            presentationMode.wrappedValue.dismiss()
                        }label: {
                            Text("取消")
                                .font(.subheadline)
                        }
                        .frame(width:70)
                        Spacer()
                        Text("发私信")
                            .font(.title3)
                        Spacer()
                        Button{
                            
                        }label: {
                            Text("多人聊天")
                                .font(.subheadline)
                        }
                        .frame(width:70)
                    }
                    .padding(.horizontal,5)
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("搜索好友", text: $searchtext)
                        Spacer()
                    }
                    .foregroundColor(.gray)
                    .padding(.vertical,5)
                    .padding(.horizontal,3)
                    .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal,20)
                    
                }
                .padding(.bottom,5)
                .background(.white)
                
                ScrollView{
                    VStack(spacing:20){
                        HStack{
                            Text("全部关注")
                            Spacer()
                        }
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal,10)
                        
                        HStack(spacing:0){
                            Image("IMG_6415")
                                .CircleImage(width: 60)
                            Text("username")
                            Spacer()
                        }
                        .padding(.vertical,10)
                        .padding(.trailing,10)
                        .background(.white)
                        
                        HStack{
                            Text("A")
                            Spacer()
                        }
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal,10)
                        
                        HStack(spacing:0){
                            Image("IMG_6415")
                                .CircleImage(width: 60)
                            Text("username")
                            Spacer()
                        }
                        .padding(.vertical,10)
                        .padding(.trailing,10)
                        .background(.white)
                    }
                    
                }
                
            }
            .background(.gray.opacity(0.15))
            .foregroundColor(.black)
        }

}

struct IncreaseChat_Previews: PreviewProvider {
    static var previews: some View {
        IncreaseChat()
    }
}
