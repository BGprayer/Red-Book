//
//  SearchDetial.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/17.
//

import SwiftUI

struct SearchDetial: View {
    @State var searchtext = ""
    @State var select = 0
    @Environment(\.presentationMode) var  presentationMode
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Image(systemName: "chevron.backward")
                }
                .foregroundColor(.black)
                HStack{
                    TextField("搜索的关键词",text: $searchtext)
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .background(.gray,in:Circle())
                }
                .padding(8)
                .background(.gray.opacity(0.2),in:RoundedRectangle(cornerRadius: 20))
            }
            ScrollView(showsIndicators: false ){
                HStack(spacing:40){
                    Button{
                        withAnimation{
                            select = 0
                        }
                    }label: {
                        Text("全部")
                    }
                    .foregroundColor(select == 0 ? .black:.gray)
                    
                    Button{
                        withAnimation{
                            select = 1
                        }
                    }label: {
                        Text("用户")
                    }
                    .foregroundColor(select == 1 ? .black:.gray)
                }
                .padding(.vertical,10)
                Divider()
                
                TabView(selection: $select){
                    SearchDetial1()
                        .tag(0)
                    SearchDetial2()
                        .tag(1)
                }
                .frame(minHeight:700,maxHeight: .infinity)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .padding(.horizontal)
    }
}

struct SearchDetial_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetial()
    }
}
