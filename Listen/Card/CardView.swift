//
//  CardView.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/11.
//

import SwiftUI
import Parse

struct CardView: View {
//    var namespace : Namespace.ID
    var index : Int
    @State var card : Carddata
    @EnvironmentObject var mycarddatas : Model
    @EnvironmentObject var Myclientdata  : ClientData
    @State var LoveInt = 0
    @State var isLoved = false
    
    func isloved(){
        let query = PFQuery(className: "Love")
        query.whereKey("myobjectid", equalTo: Myclientdata.MyClient.username)
        query.whereKey("pyqobjectid", equalTo: card.pyqobjectid)
        query.whereKey("Isshow", equalTo: true)
        query.getFirstObjectInBackground { obj, error in
            if obj != nil{
                isLoved = true
            }
        }
    }
    
    var body: some View {
        //新建为一个View，方便调用
        VStack(alignment: .leading,spacing: 5){
            PublicURLImageView(imageurl:card.publishimageurl.count != 0 ? card.publishimageurl[0]:"http://localhost:1337/parse/files/8888/c8e6d775f89af4a065864db514d66797_image.png", contentmode: false)
            
            HStack{
                Text(card.title)
                Spacer()
            }
            .transition(.opacity)
            
            HStack(spacing:5){
                //头像
                PublicURLImageView(imageurl:card.client.clientimage,contentmode: true)
                        .mask(Circle())
                        .frame(width: 30, height: 30)
                
                Text(card.client.clientname)
                Spacer()
                Image(systemName: isLoved ?  "heart.fill":"heart")
                    .foregroundColor(isLoved ? .red:.black)
                Text("\(card.love)")
                
            }
            .font(.footnote)
            .padding(.horizontal,5)
            .transition(.opacity)
            
        }
        //将宽度设置成一半
        .background(Color.white)
        .mask(RoundedRectangle(cornerRadius: 10))
        .onAppear {
            isloved()
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    @Namespace static var namespace
//    static var previews: some View {
//        CardView(namespace: namespace)
//    }
//}
