//
//  HttpManager.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/1/19.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit
import Alamofire

class HttpManager: NSObject {
    struct global {
        let SPCODE = "0002";
        
    }
      static let appkey = "99999999"
      static let appsecret = "COaFpf69BverHMdhVIBIOPMmwwnRwuxM"
      static let appsale = "COaFpf69BverHMdhVIBIOPMmwwnRwuxM"
      static let ERPBaseUrl = "http://125.62.14.157:8183"
      static func getToken() -> Void {
        //获取设备号
        let deviceNmber:String = (UIDevice.current.identifierForVendor?.uuidString)!;
        //获取时间戳
        let formatter = DateFormatter.init();
        formatter.dateFormat = "YYYY-MM-dd hh:mm:ss:SSS";
        let  date:Date = Date.init(timeIntervalSinceNow: 0);
        
        let time:TimeInterval = date.timeIntervalSince1970;
        let timeC:CLongLong = CLongLong(NSNumber.init(floatLiteral:time).intValue);
        let timeString:String = String(timeC);
        //print("当前日期为:"+formatter.string(from: date));
        //print("当前的时间戳为:"+timeString);
        
        //配置请求参数
            //let appkey = "99999999"
            //let appsecret = "COaFpf69BverHMdhVIBIOPMmwwnRwuxM"
            //let appsale = "COaFpf69BverHMdhVIBIOPMmwwnRwuxM"
            
            let first:String = String(appkey+timeString).md5();
            let second:String = String(first+appsecret).md5();
            let third:String = String(second+appsale+deviceNmber).md5();
            
            var dic = [String:String]();
            dic["app_key"] = appkey;
            dic["app_secret"] = appsecret;
            dic["devid"] = deviceNmber;
            dic["ts"] = timeString;
            dic["sign"] = third;
            dic["api"] = "open.token";
            dic["ver"] = "1.0";
            dic["format"] = "json";
            
//            let headers: HTTPHeaders = [
//                "Content-Type":"application/json;charset=utf-8",
//                "Accept": "application/json",
//                "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ=="
//            ]
//
//            Alamofire.request("http://125.62.14.157:8183", method: .post, parameters: dic, encoding: URLEncoding.default, headers:headers).responseString{ (response) in
//                if(response.error == nil){
//                    print(response.result.value);
//                   // print(response.result.value ?? "sda");
//
//                }else{
//                    print(response.error!);
//                }
//
//            }
        _ = DispatchQueue.global().async {
                
                let userDefault = UserDefaults.standard;
                
                let url:URL = URL(string:ERPBaseUrl)!;
                var requst = URLRequest(url:url);
                requst.httpMethod = "POST";
                let data = try? JSONSerialization.data(withJSONObject: dic, options: []);
                requst.httpBody = data;
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                let dataTask = session.dataTask(with: requst) { (data, response, error) in
                    
                    let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    
                    //let str:String! = String(data: data!, encoding: String.Encoding.utf8)
                    if (error == nil)
                    {
                       // print(json as! NSDictionary);
                        let result = json!.object(forKey: "code") as! String
                        if (result == "success")
                        {
                            let dic = json!["body"] as! NSDictionary;
                            userDefault.setValue(dic["token"], forKey: "ERPToken");
                            //print(userDefault.object(forKey: "ERPToken") ?? "为空");
                        }
                        else
                        {
                            print(json!.object(forKey: "message")!)
                        }
                    }
                    else
                    {
                        print(error!);
                    }
                    
                };
                
                dataTask.resume();
            };
            
           print("先执行")
            
            
    }
    
static func postERPUrl(url:String,para:NSMutableDictionary,successBlock: @escaping (NSDictionary)->Void) -> Void{
        
        let deviceNmber:String = (UIDevice.current.identifierForVendor?.uuidString)!;
        //获取时间戳
        let formatter = DateFormatter.init();
        formatter.dateFormat = "YYYY-MM-dd hh:mm:ss:SSS";
        let  date:Date = Date.init(timeIntervalSinceNow: 0);
        
        let time:TimeInterval = date.timeIntervalSince1970;
        let timeC:CLongLong = CLongLong(NSNumber.init(floatLiteral:time).intValue);
        let timeString:String = String(timeC);
        
        let first:String = String(appkey+timeString).md5();
        let second:String = String(first+appsecret).md5();
        let third:String = String(second+appsale+deviceNmber).md5();
    
        para["app_key"] = appkey;
        para["app_secret"] = appsecret;
        para["devid"] = deviceNmber;
        para["ts"] = timeString;
        para["sign"] = third;
        para["ver"] = "1.0";
        para["json"] = "format";
        para["token"] = UserDefaults.standard.object(forKey: "ERPToken")
        para["api"] = url;
    //print(para);
    let url:URL = URL(string:ERPBaseUrl)!
    var requset = URLRequest(url:url);
    let data = try? JSONSerialization.data(withJSONObject: para, options: []);
    requset.httpBody = data;
    requset.httpMethod = "POST";
    requset.timeoutInterval = 10;
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    DispatchQueue.global().async {
        
        let dataTask = session.dataTask(with: requset) { (data, response, error) in
            
            
            if (error == nil)
            {
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                let result = json!.object(forKey: "code") as! String
                if (result == "success")
                {
                    
                   DispatchQueue.main.async {
                        successBlock(json!)
                   }
                    
                    
                }
                else
                {
                    print(json!.object(forKey: "msg") ?? "请求失败")
                }
            }
            else
            {
                print(error!);
            }
            
        }
        dataTask.resume();
        
    }
    
    
    
    }
}

