//
//  ListenView.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/11.
//

import SwiftUI

struct ListenView: View {
    @Namespace var namespace
    @State var select = 1
    @State var isshowdetial = false
    @State var isshow = false
    @State var showContend = false
    @EnvironmentObject var mycarddatas : Model
    @EnvironmentObject var pyqdata : PYQData
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var mynotdata : NoticeData
    @State var showsearch = false
    @State var showaccountdetial : Bool = false
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    //顶部导航
                    HStack{
                        Button{
                            
                        }label: {
                            Image(systemName: "globe.europe.africa")
                        }
                        .foregroundColor(.black)
                        
                        Spacer()
                        HStack(spacing:28){
                            
                            // 导航栏
                            Button{
                                select = 0
                            }label: {
                                Text("关注")
                                    .foregroundColor(select == 0 ? .black:.gray)
                            }
                            
                            Button{
                                select = 1
                            }label: {
                                Text("发现")
                                    .foregroundColor(select == 1 ? .black:.gray)
                            }
                            
                        }
                        .padding(.bottom,5)
                        .overlay(
                            HStack{
                                
                                if select == 1{
                                    Spacer()
                                }
                                VStack{
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 30, height: 3)
                                        .foregroundColor(.pink)
                                }
                                
                                if select == 0{
                                   
                                    Spacer()
                                }
                            }
                            .padding(.horizontal,3)
                        )

                        Spacer()
                        Button{
                            withAnimation{
                                showsearch = true
                            }
                        }label: {
                            Image(systemName: "magnifyingglass")
                        }
                        .foregroundColor(.black)
                        
                    }
                    .foregroundColor(.black)
                    .padding(.top,50)
                    .padding(.horizontal,10)
                    Divider()
                    
                    
                    //主题内容
                    TabView(selection: $select){
                        ConcernView(showContend:$showContend , isshow: $isshow, showaccountdetial: $showaccountdetial)
                            .tag(0)
                        
                        Find(isshowdetial: $isshowdetial)
                            .tag(1)
                        
                        
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    
                    //底部内容
                    Tabbar()
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarHidden(true)
                

                .FullScreenCard(isPresented: $showsearch) {
                    SearchView(showsearch: $showsearch)
                        .navigationBarHidden(true)
                }
//                .SheetBottomView(isPresented: $showContend,onDismiss: {
//                    
//                }){
//                    CardTwoDetial(showContend: $showContend)
//                }
                
            }
        }
    }
}

struct ListenView_Previews: PreviewProvider {
    static var previews: some View {
        ListenView()
            .environmentObject(Model())
    }
}
