//
//  ListenApp.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/11.
//

import SwiftUI
import Parse

@main
struct ListenApp: App {
    init(){
        let parseconfig = ParseClientConfiguration {
            $0.applicationId = "8888"
            $0.clientKey = "8888"
            $0.server = "http://localhost:1337/parse"
            // 替换自己的ip地址 或者改成 "http://localhost:1337/parse"
        }
        Parse.initialize(with: parseconfig)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(Model())
                .environmentObject(ClientData(FromOutMyClient: initMyClientData()))
                .environmentObject(PYQData(allPyqData: initPqyData()))
                .environmentObject(SaveobjectData(SaveObject: initSaveObject()))
        }
    }
}
