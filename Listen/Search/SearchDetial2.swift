//
//  SearchDetial2.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/17.
//

import SwiftUI

struct SearchDetial2: View {
    var body: some View {
        VStack{
            ForEach(0..<10){ item in
                HStack(alignment:.top){
                    Image("IMG_6415")
                        .CircleImage(width: 50)
                    VStack(alignment: .leading,spacing: 0){
                        Text("小宇elf")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        HStack{
                            Text("笔记")
                            Text("1000")
                            Divider()
                                .frame(height:15)
                            Text("粉丝")
                            Text("520w")
                        }
                        .font(.footnote)
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button{
                        
                    }label: {
                        Text("关注").foregroundColor(.pink)
                            .padding(.vertical,5)
                            .padding(.horizontal,18)
                            .background(.white)
                            .padding(1)
                            .background(.pink,in : RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            Spacer()
        }
    }
}

struct SearchDetial2_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetial2()
    }
}
