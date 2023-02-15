//
//  Tabbar.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/11.
//

import SwiftUI

enum Selection{
    case home
    case reduce
    case classes
    case me
}
struct Tabbar: View {
    @EnvironmentObject var model : Model
    @EnvironmentObject var mySaveobject : SaveobjectData
    @State var showplusview = false
    @State var showplishview = false
    var body: some View {
        HStack{
            HStack{
                Spacer()
                Button{
                    
                    model.select = .home
                }label: {
                    Text("推荐")
                }
                .foregroundColor(model.select == .home ? .black : .gray)
                Spacer()
                
                Button{
                    
                    model.select = .reduce
                }label: {
                    Text("减压厅")
                }
                .foregroundColor(model.select == .reduce ? .black : .gray)

                Spacer()
                
            }
            
            Button{
                withAnimation {
                    if mySaveobject.Saveobjects.mysavedimage == [] && mySaveobject.Saveobjects.mypyqmessage.content == "" && mySaveobject.Saveobjects.mypyqmessage.title == ""{
                        showplusview = true
                    }else{
                        showplusview = false
                        showplishview = true
                    }
                }
            }label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(.vertical,6)
                    .padding(.horizontal,12)
                    .background(.red,in: RoundedRectangle(cornerRadius: 8))
            }
            
            HStack{
                Spacer()
                Button{
                    
                    model.select = .classes
                }label: {
                    Text("微课堂")
                }
                .foregroundColor(model.select == .classes ? .black : .gray)

                Spacer()
                
                Button{
                    
                    model.select = .me
                }label: {
                    Text("听我说")
                }
                .foregroundColor(model.select == .me ? .black : .gray)

                Spacer()
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height:50)
        .fullScreenCover(isPresented: $showplusview) {
                PlusView(showplusview: $showplusview)
                    
        }
        .fullScreenCover(isPresented: $showplishview) {
            PYQPublishView(mytitle: mySaveobject.Saveobjects.mypyqmessage.title, mycontent: mySaveobject.Saveobjects.mypyqmessage.content, images:mySaveobject.convert2(images: mySaveobject.Saveobjects.mysavedimage),locate: mySaveobject.Saveobjects.mypyqmessage.locate)
         
        }
        .padding(.bottom)
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
            .environmentObject(Model())
            .environmentObject(PYQData(allPyqData: initPqyData()))
            .environmentObject(SaveobjectData(SaveObject: initSaveObject()))
    }
}
