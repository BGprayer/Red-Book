//
//  NewConcern.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/23.
//

import SwiftUI

struct NewConcern: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mynotdata : NoticeData
    @State var dates : Date = Date()
        
    func MyDateFormatter(dates: Date) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        return dateformatter.string(from: dates)
    }

    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(mynotdata.MyFans){ item in
                    if !item.ismutual{
                        HStack(spacing:0){
                            PublicURLImageView(imageurl: item.client.clientimage, contentmode: true)
                                .mask(Circle())
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment:.leading,spacing: 5){
                                Text(item.client.clientname)
                                HStack{
                                    Text("开始关注你了")
                                    Text(MyDateFormatter(dates:dates))
                                }
                                .font(.footnote)
                                .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            Button{
                                
                            }label: {
                                Text("回粉")
                                    .foregroundColor(.pink)
                                    .padding(.vertical,5)
                                    .padding(.horizontal,20)
                                    .background(.white)
                                    .padding(1)
                                    .background(.pink,in: RoundedRectangle(cornerRadius: 20))
                            }
                            
                        }
                        .padding(.vertical,10)
                        .padding(.trailing,10)
                        Divider()
                    }
               }
            }
            .navigationTitle("新增关注")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

struct NewConcern_Previews: PreviewProvider {
    static var previews: some View {
        NewConcern()
    }
}
