//
//  SearchView.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/16.
//

import SwiftUI

struct SearchView: View {
    @State var searchtext : String = ""
    @Binding var showsearch : Bool
    var body: some View {
        NavigationView{
        VStack{
            HStack{ //Search
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("搜索什么", text: $searchtext)
                }
                .padding(5)
                .background(.gray.opacity(0.2),in:RoundedRectangle(cornerRadius: 20))
                
                Button{
                    withAnimation{
                        showsearch = false
                    }
                }label: {
                    Text("取消")
                }
            }
            .foregroundColor(.gray)
            .transition(.move(edge: .trailing))
            .animation(.linear, value: showsearch)
            ScrollView{
                //关键词
                if searchtext == ""{
                    VStack{
                        VStack{
                            HStack{
                                Text("历史记录")
                                    .font(.system(size: 18))
                                Spacer()
                                Image(systemName: "trash")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack{
                                Button{
                                    
                                }label: {
                                    Text("周杰伦新歌").foregroundColor(.black)
                                        .padding(.vertical,5)
                                        .padding(.horizontal,18)
                                        .background(.white)
                                        .padding(1)
                                        .background(.gray,in : RoundedRectangle(cornerRadius: 20))
                                }
                                
                                Button{
                                    
                                }label: {
                                    Text("SwiftUI").foregroundColor(.black)
                                        .padding(.vertical,5)
                                        .padding(.horizontal,18)
                                        .background(.white)
                                        .padding(1)
                                        .background(.gray,in : RoundedRectangle(cornerRadius: 20))
                                }
                                Spacer()
                                
                            }
                        }
                        
                        VStack(spacing:20){
                            HStack{
                                Text("猜你想搜")
                                    .font(.system(size: 18))
                                Spacer()
                                HStack{
                                    Image(systemName: "arrow.clockwise")
                                        .font(.footnote)
                                    Text("换一换")
                                }
                                .foregroundColor(.gray)
                            }
                            
                            
                            HStack(spacing:60){
                                VStack(alignment:.leading,spacing:15){
                                    Text("2022流行音乐")
                                    Text("王者荣耀")
                                }
                                
                                VStack(alignment:.leading,spacing:15){
                                    Text("2022微博之夜")
                                    Text("iPhone14")
                                }
                                Spacer()
                            }
                        }
                        .padding(.vertical)
                        
                        VStack{
                            HStack{
                                Text("搜索发现")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 18))
                                Spacer()
                            }
                            
                            VStack(spacing:15){
                                HStack{
                                    Circle()
                                        .frame(width:5,height: 5)
                                        .foregroundColor(.red)
                                    Text("EDG获得S12世界总决赛冠军")
                                    Spacer()
                                    Text("6253w")
                                    Text("—")
                                }
                                Divider()
                                HStack{
                                    Circle()
                                        .frame(width:5,height: 5)
                                        .foregroundColor(.orange)
                                    Text("EDG成功卫冕S12")
                                    Spacer()
                                    Text("6147w")
                                    Image(systemName: "arrow.up")
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                }
                                Divider()
                                HStack{
                                    Circle()
                                        .frame(width:5,height: 5)
                                        .foregroundColor(.yellow)
                                    Text("Viper获得S12FMvp")
                                    Spacer()
                                    Text("5986w")
                                    Image(systemName: "arrow.up")
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                }
                                Divider()
                                HStack{
                                    Circle()
                                        .frame(width:5,height: 5)
                                        .foregroundColor(.gray)
                                    Text("Scout逆天改命")
                                    Spacer()
                                    Text("5877w")
                                    Image(systemName: "arrow.up")
                                        .font(.footnote)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
                else{
                    VStack{
                        ForEach(0..<10){ item in
                            NavigationLink{
                                SearchDetial()
                                    .navigationBarHidden(true)
                            }label: {
                                HStack{
                                    Text("hhh")
                                    Spacer()
                                }
                            }
                            Divider()
                        }
                    }
                    .foregroundColor(.black)
                }
                
            }
        }
        .padding(.horizontal,20)
        .background(.white)
        .navigationBarHidden(true)
    }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(showsearch: .constant(false))
    }
}
