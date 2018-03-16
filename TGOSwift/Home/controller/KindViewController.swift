//
//  KindViewController.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/3/12.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit

class KindViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let array = NSArray.init(objects: "美容养颜","健康","增强免疫力","竹叶青","汾酒","护理和保健品","平牌奶粉","茶叶","美妆护肤","电水壶")
        
        let topView = SortControlScroll.init(frame: CGRect.init(x: 0, y: 100, width: SCREEN_WIDTH, height: 40))
        topView.dataArray = array
        self.view.addSubview(topView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
