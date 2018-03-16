//
//  Global.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/1/25.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public let SPCODE = "0002";
public let HOME_ID = "19";
public let TABBARHEIGHT = SCREEN_HEIGHT > 800 ? 83 : 49

public let NAVHEIGHT = SCREEN_HEIGHT > 800 ? 88 : 64

public func WIDTH(num:Int) -> Float{
    let tran = Float(num)*Float(SCREEN_WIDTH)/375
    return tran
    
}
class Global: NSObject {

}
