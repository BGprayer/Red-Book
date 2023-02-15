//
//  MainView.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/18.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var model : Model
    @AppStorage("islogin") var islogin = false
    var body: some View {
        if !islogin{
            SignIn()
        }
        else{
            switch model.select{
            case .home:
                ListenView()
                    .environmentObject(NoticeData())
            case.reduce:
                ReduceView()
                    .environmentObject(NoticeData())
            case.classes:
                NotView()
                    .environmentObject(NoticeData())
            case.me:
                AccountView()
                    .environmentObject(NoticeData())
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Model())
            .environmentObject(ClientData(FromOutMyClient: initMyClientData()))
            .environmentObject(PYQData(allPyqData: initPqyData()))
            .environmentObject(SaveobjectData(SaveObject: initSaveObject()))
            .environmentObject(PYQData(allPyqData: initPqyData()))
    }
}
