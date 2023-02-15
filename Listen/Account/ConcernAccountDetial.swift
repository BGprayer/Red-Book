//
//  ConcernAccountDetial.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/15.
//

import SwiftUI

struct ConcernAccountDetial: View {
    var otherclient : Client
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var pyqdata : PYQData
    @EnvironmentObject var mycarddatas : Model
    @EnvironmentObject var mynotdata : NoticeData
    @State var mypyq : [Carddata] = []
    @State var myStarpyq : [Carddata] = []
    @Environment(\.presentationMode) var presentationMode
    @State var selcet = 0
    @Binding var showaccountdetial : Bool
    @State var scrollsize : CGFloat = 0
    @State var dragsize : CGFloat = 0
    @State var scrollsizeall : CGFloat = 0
    @State var loveint = 0
    @State var starInt = 0
    @State var isConcern : Bool = false
    @State var showLoveandStar : Bool = false
    
    func GetMyPyq(){
        if mypyq.isEmpty{
            for i in pyqdata.allPyqData{
                if i.client.clientname == otherclient.clientname{
                    self.mypyq.append(i)
                }
            }
        }
    }
    
    
    
    var body: some View {
        NavigationView{
        VStack{
            VStack{
                    VStack{
                        Color.clear.frame(height: 40)
                        VStack(alignment:.leading){
                            HStack{
                                PublicURLImageView(imageurl:otherclient.clientimage, contentmode: true)
                                    .mask(Circle())
                                    .frame(width: 65, height: 65)
                                    .padding(.top,5)
                                    .padding(.leading)
                                
                                VStack(alignment:.leading,spacing: 8){
                                    Text(otherclient.clientname)
                                        .font(.title)
                                        .foregroundColor(.white)
                                    Text("账号:\(otherclient.username)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            
                           
                                
                        
                            HStack{
                                Text(otherclient.introduction != "" ? otherclient.introduction:"ta还没有留下简介哦")
                                Image(systemName: "pencil")
                                Spacer()
                            }
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .padding(.bottom)
                            
                            HStack{
                             
                                Text("\(Getold(date:otherclient.birthday))")
                                    .foregroundColor(.white)
                                    .font(.footnote)
                                    .padding(.vertical,2)
                                    .padding(.horizontal,20)
                                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                
                                
                                    
                            
                                Text(otherclient.locate)
                                    .foregroundColor(.white)
                                    .font(.footnote)
                                    .padding(.vertical,2)
                                    .padding(.horizontal,20)
                                    .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                            
                            HStack(spacing:15){
                                VStack{
                                    Text("0")
                                    Text("关注")
                                        .font(.caption2)
                                }
                                VStack{
                                    Text("0")
                                    Text("粉丝")
                                        .font(.caption2)
                                }
                                
                                Button{
                                    withAnimation {
                                        showLoveandStar = true
                                    }
                                }label: {
                                    VStack{
                                        Text("0")
                                        Text("点赞和收藏")
                                            .font(.caption2)
                                    }
                                }
                               
                                
                                Spacer()
                                
                                
                                if isConcern{
                                    Button{
                                        
                                    }label: {
                                        Text("发消息")
                                            .foregroundColor(.white)
                                            .padding(.vertical,2)
                                            .padding(.horizontal,20)
                                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                    }
                                    
                                    Button{
                                        
                                    }label: {
                                        // 不再关注
                                        Image(systemName: "person.fill.checkmark")
                                            .foregroundColor(.white)
                                            .padding(.vertical,2)
                                            .padding(.horizontal,10)
                                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                    }
                                    
                                }else{
                                    Button{
                                        
                                    }label: {
                                        Text("关注")
                                            .foregroundColor(.pink)
                                            .padding(.vertical,5)
                                            .padding(.horizontal,18)
                                            .background(.white)
                                            .padding(1)
                                            .background(.pink,in : RoundedRectangle(cornerRadius: 20))
                                    }
                                    
                                    Button{
                                        
                                    }label: {
                                        Image(systemName: "mic")
                                            .foregroundColor(.white)
                                            .padding(.vertical,2)
                                            .padding(.horizontal,20)
                                            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.top)
                
                VStack{
                    HStack(spacing:40){
                        Button{
                            selcet = 0
                        }label: {
                            Text("笔记")
                                .foregroundColor(selcet == 0 ? .black:.gray)
                        }
                        Button{
                            selcet = 1
                        }label: {
                            Text("收藏")
                                .foregroundColor(selcet == 1 ? .black:.gray)
                        }
                    }
                    .padding(.top,10)
                  
                    TabView(selection:$selcet){
                        NotBookView(mypyq: mypyq,dragsize: $dragsize,scrollsize:$scrollsize,scrollsizeall: $scrollsizeall)
                            .tag(0)

                        NotBookView(mypyq: myStarpyq,dragsize: $dragsize,scrollsize:$scrollsize,scrollsizeall: $scrollsizeall)
                            .tag(1)
                    }
                    .padding(.top,20)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(minHeight:UIScreen.main.bounds.height * 0.55 ,maxHeight: UIScreen.main.bounds.height)
                }
                .foregroundColor(.black)
                .background(.white,in: RoundedRectangle(cornerRadius:30))
//                .offset(y:showaccountdetial ? 0:-50)
            }
            .coordinateSpace(name: "scroll")
            .overlay(
                VStack{
                    HStack{
                        Button{
                            presentationMode.wrappedValue.dismiss()
                        }label: {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 20))
                        }
                        Button{
                            
                        }label: {
                            Text("发消息")
                                .foregroundColor(.black)
                                .frame(width:80, height: 30)
                                .background(.white)
                                .padding(1)
                                .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 10))
                        }
                        .opacity(0)
                        
                        Spacer()
                        
                        PublicURLImageView(imageurl: otherclient.clientimage, contentmode: true)
                            .mask(Circle())
                            .frame(width: 30, height: 30)
                            .offset(y:55)
                           .offset(y:dragsize)
                           .opacity(-dragsize)
                        
                        Spacer()
                        
                        Button{
                            
                        }label: {
                            Text("发消息")
                                .foregroundColor(.black)
                                .frame(width:80, height: 30)
                                .background(.white)
                                .padding(1)
                                .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 10))
                        }
                      
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .padding(.top,40)
                    .padding(.bottom,10)
                    .background(dragsize < 0  ? .gray.opacity(-dragsize / 50):.clear)
                    Spacer()
                }
            )
        }
        .background(
            PublicURLImageView(imageurl: otherclient.clientbackground, contentmode: true)
                .clipped()
                .scaleEffect(scrollsize != 0 ? (scrollsize / 600 + 1):1)
                .offset(y:-600)
        )
        .frame(width: UIScreen.main.bounds.width)
        .navigationBarHidden(true)
        .onAppear {
//            GetMyInt()
//            Jugement()
            GetMyPyq()
//            GetMyStar()
        }
        .SheetCenterView(isPresented: $showLoveandStar) {
            VStack{
                Text("获赞与收藏")
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                
                Divider()
                
                VStack(spacing:18){
                    HStack(spacing:12){
                        Image(systemName: "square.text.square.fill")
                            .foregroundColor(.white)
                            .padding(3)
                            .background(.blue,in:Circle())
                        Text("当前发布笔记数")
                            .foregroundColor(.gray)
                        Text("\(mypyq.count)")
                    }
                    
                    HStack(spacing:12){
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                            .padding(3)
                            .background(Color("red"),in:Circle())
                        Text("当前获得点赞数")
                            .foregroundColor(.gray)
                        Text("\(loveint)")
                    }
                    
                    HStack(spacing:12){
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                            .padding(3)
                            .background(.yellow,in:Circle())
                        Text("当前获得收藏数")
                            .foregroundColor(.gray)
                        Text("\(starInt)")
                    }
                }
                .padding(.horizontal,15)
                .padding(.vertical)
                Button{
                    withAnimation {
                        self.showLoveandStar = false
                    }
                }label: {
                    Text("我知道了")
                        .foregroundColor(.white)
                        .frame(width: 140, height: 40)
                        .background(Color("red"),in:RoundedRectangle(cornerRadius: 20))
                }
            }
            .frame(width: UIScreen.main.bounds.width / 2 + 30,height: UIScreen.main.bounds.height / 3 - 20 )
            .background(.white,in:RoundedRectangle(cornerRadius: 10))
        }
    }
        
}
}



struct ScrollPreferenceKey : PreferenceKey{
    static var defaultValue : CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

//struct ConcernAccountDetial_Previews: PreviewProvider {
//    static var previews: some View {
//        ConcernAccountDetial(showaccountdetial: .constant(false))
//    }
//}
