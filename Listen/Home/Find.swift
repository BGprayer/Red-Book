//
//  Find.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/12.
//

import SwiftUI

struct Find: View {
//    var namespace : Namespace.ID
    @Binding var isshowdetial : Bool
    @State var isscroll : Bool = false
    @EnvironmentObject var mycarddatas : Model
    @EnvironmentObject var pyqdata : PYQData
    var body: some View {
        ZStack{
            VStack{
                AllCard(viewname: "发现",isshowdetial: $isshowdetial, isscroll: $isscroll)
                
            }
            
        }
    }
}

struct Find_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        Find(isshowdetial: .constant(false))
            .environmentObject(Model())
            .environmentObject(PYQData(allPyqData: initPqyData()))
    }
}
