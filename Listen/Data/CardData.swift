//
//  CardData.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/14.
//

import SwiftUI

// 一个是数组 还有一个是结构体 还有一个是class类型

class Model : ObservableObject{
    @Published var select : Selection = .home
    @Published var selection : Int = 0
    @Published var selectobject :Carddata =  Carddata(title: "", content: "", locate: "", publishtime: Date(), publishimageurl: [], pinlun: [], love: 0, star: 0, pyqobjectid: "", client:  Client(username: "", clientname: "", introduction: "", sex: "", locate: "", clientimage: "", clientbackground: "", birthday: Date(), school: ""))
    @Published var myselectobjectid : String = ""
    @Published var selectionvuew : String = ""
    
}

struct Carddata : Identifiable,Codable,Equatable{
    var id = UUID()
    var title : String
    var content : String
    var locate : String
    var publishtime : Date
    var publishimageurl : [String]
    var pinlun : [MyPinlun]
    var love : Int
    var star : Int
    var pyqobjectid : String
    var client : Client
}
