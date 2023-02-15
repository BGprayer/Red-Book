//
//  ShareView.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/15.
//

import SwiftUI

struct ShareView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "xmark")
                    .opacity(0)
                Spacer()
                Text("分享至")
                Spacer()
                Image(systemName: "xmark")
            }
            .foregroundColor(.gray)
            
            HStack{
                VStack(spacing:0){
                    Image("IMG_6415")
                        .CircleImage(width: 60)
                    Text("jsh")
                }
                VStack(spacing:0){
                    Image("IMG_6416")
                        .CircleImage(width: 60)
                    Text("xyj")
                }
                Spacer()
            }
            
            Divider()
            HStack{
                
            }
            HStack{
                
            }
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
