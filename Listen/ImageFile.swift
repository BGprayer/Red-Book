//
//  ImageFile.swift
//  Listen
//
//  Created by 项宇杰 on 2022/8/12.
//

import SwiftUI

extension Image{
    func CircleImage(width:CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .mask(Circle())
            .frame(width: width,height: width)
    }
}

extension String : Identifiable{
    public var id : Int{
        return self.hashValue
    }
}
extension UIImage : Identifiable{
    public var id : Int{
        return self.hashValue
    }
}


extension UINavigationController : UIGestureRecognizerDelegate{
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


func DateFormmatter2(date:Date)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let datetime = formatter.string(from: date)
    return datetime
}

func DateFormmatter(date:Date)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd"
    let datetime = formatter.string(from: date)
    return datetime
}
