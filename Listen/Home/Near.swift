//
//  Near.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/12.
//

import SwiftUI

struct Near: View {
    @Namespace var namespace
    var body: some View {
        ScrollView{
            HStack(alignment: .top){
                //在这里调用Card
                VStack{
                }
                VStack{
                }
                Spacer()
               
            }
            Spacer()
        }
        .background(.gray.opacity(0.1))
    }
}

struct Near_Previews: PreviewProvider {
    static var previews: some View {
        Near()
    }
}
