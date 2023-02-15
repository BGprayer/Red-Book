//
//  ConcernView.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/12.
//

import SwiftUI

struct ConcernView: View {
    @EnvironmentObject var Myclientdata  : ClientData
    @EnvironmentObject var pyqdata : PYQData
    @State var Myconcernpyq : [Carddata] = []
    @EnvironmentObject var mynotdata : NoticeData
    @Binding var showContend : Bool
    @Binding var isshow : Bool
    @State var text = ""
    @Binding var showaccountdetial : Bool
    
    func GetMyconcernPyq(){
        if Myconcernpyq.isEmpty{
            for item in mynotdata.Myconcern{
                for i in pyqdata.allPyqData{
                    if i.client.username == item.client.username{
                        self.Myconcernpyq.append(i)
                    }
                }
            }
        }

        self.Myconcernpyq = Myconcernpyq.sorted { car1, card2 in
            car1.publishtime < card2.publishtime
        }
    }
    var body: some View {
            ScrollView{
                    // 关注
                    HStack{
                        Button{
                            withAnimation {
                                isshow = true
                            }
                        }label: {
                            VStack(spacing:0){
                                PublicURLImageView(imageurl: Myclientdata.MyClient.clientimage, contentmode: true)
                                    .mask(Circle())
                                    .frame(width: 60, height: 60)
                                Text("分享瞬间")
                                    .font(.footnote)
                            }
                        }
                        Spacer()
                    }
                    .padding(15)
                // 关注的人发的内容
                if Myconcernpyq.count == 0{
                    Text("--------你的关注还没有发动态哦--------")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .padding(.horizontal)
                }else{
                    ForEach(Myconcernpyq){ item in
                        CardTwo(card: item, showContend: $showContend, showaccountdetial: $showaccountdetial)
                    }
                }
            }
            .foregroundColor(.black)
            .onAppear {
                GetMyconcernPyq()
            }
    }
}

struct ConcernView_Previews: PreviewProvider {
    static var previews: some View {
        ConcernView(showContend: .constant(false), isshow: .constant(false), showaccountdetial: .constant(false))
    }
}
