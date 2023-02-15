//
//  SearchDetial1.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/17.
//

import SwiftUI

struct SearchDetial1: View {
    @State var selectSort = 0
    @State var selectContend = 0
    var body: some View {
        VStack{
            HStack(spacing:20){
                Button{
                    withAnimation{
                        selectSort = 0
                    }
                }label: {
                    Text("综合")
                }
                .foregroundColor(selectSort == 0 ? .black:.gray)
                
                Button{
                    withAnimation{
                        selectSort = 1
                    }
                }label: {
                    Text("最热")
                }
                .foregroundColor(selectSort == 1 ? .black:.gray)
                
                Button{
                    withAnimation{
                        selectSort = 2
                    }
                }label: {
                    Text("最新")
                }
                .foregroundColor(selectSort == 2 ? .black:.gray)
                
                Spacer()
            }
            .frame(height:30)
            
            Divider()
            TabView(selection: $selectSort){
                
            }
        }
        
    }
}

struct SearchDetial1_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetial1()
    }
}
