//
//  Text1.swift
//  Listen
//
//  Created by 项宇杰 on 2022/9/17.
//

import SwiftUI

struct Text2: View {
    @State private var popoverIsShown = false
    var body: some View {
        Button("显示 Sheet") {
            self.popoverIsShown = true
        }
        .sheet(isPresented: self.$popoverIsShown) {
            RandomSheet(popoverIsShown: self.$popoverIsShown)
        }
    }
}

struct RandomSheet: View {
    @Binding var popoverIsShown: Bool
    var body: some View {
        Button("关闭") { self.popoverIsShown = false }
    }
}




struct Text2_Previews: PreviewProvider {
    static var previews: some View {
        Text2()
    }
}
