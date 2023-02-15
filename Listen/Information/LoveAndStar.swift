//
//  LoveAndStar.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/22.
//

import SwiftUI

func GetTime(date:Date)->String{
    let distance = date.distance(to: Date()) // 秒
    // 一分钟 60s  一小时 60分钟  一天 24小时  一年 365天 一年31536000秒
    let date = Int(distance) / (86400)
    if date != 0{
        return "\(date)天"
    }else{
        let hour = Int(distance) / (3600)
        if hour != 0{
            return "\(hour)小时"
        }else{
            let min = Int(distance) / (60)
            if min != 0{
                return "\(min)分钟"
            }else{
                return "\(Int(distance))秒"
            }
        }
    }
}

struct LoveAndStar: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mynotdata : NoticeData
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment:.leading){
                ForEach(mynotdata.MyLoveAndStar){ item in
                    Divider()
                    HStack(alignment:.top){
                        PublicURLImageView(imageurl: item.object.clientimage, contentmode: true)
                            .mask(Circle())
                            .frame(width: 40, height: 40)
                        VStack(alignment:.leading){
                            Text(item.object.clientname)
                                .foregroundColor(.black)
                                .font(.title3)
                            
                            HStack(alignment:.bottom){
                                if item.islove {
                                    VStack(alignment:.leading){
                                        Text("赞了你的笔记")
                                        Text("\(item.pyqcontent)")
                                    }
                                }else{
                                    VStack(alignment:.leading){
                                        Text("收藏了你的笔记")
                                        Text("\(item.pyqcontent)")
                                    }
                                }
                                Text((GetTime(date:item.time)))
                                    .foregroundColor(.gray)
                                    .font(.footnote)
                            }
                        }
                        Spacer()
                        
                        PublicURLImageView(imageurl: item.pyqimageurl, contentmode: true)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .frame(width: 50, height: 100)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("收到的赞和收藏")
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

struct LoveAndStar_Previews: PreviewProvider {
    static var previews: some View {
        LoveAndStar()
    }
}
