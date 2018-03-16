//
//  OriginalHttpManager.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/1/19.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit

class OriginalHttpManager: NSObject {
  static func getRequest(str:String) -> Void {
        let url = URL(string: str);
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url!)
        //request.httpMethod = "POST";
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //发起请求
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let str:String! = String(data: data!, encoding: String.Encoding.utf8)
            print(str)
            //转Json
            let jsonData:Dictionary = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary as Dictionary
            
            print(jsonData)
            
        }
        dataTask.resume()
        
    }
    static func postRequest(string:String) -> Void{
        let url:URL = URL(string:string)!;
        var requst = URLRequest(url:url);
        requst.httpMethod = "POST";
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: requst) { (data, response, error) in
            let str:String! = String(data: data!, encoding: String.Encoding.utf8)
            print(str)
            };
        
        dataTask.resume();
        
    }
}
