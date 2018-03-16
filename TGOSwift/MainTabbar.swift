//
//  MainTabbar.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/1/17.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit

class MainTabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tabBar.tintColor = UIColor.red;
        let homePage = HomeViewController.init();
        self.createController(vc: homePage, title: "首页", photoName: "home_white", selectName: "home_red");
        let classVC = ClassViewController.init();
        self.createController(vc: classVC, title: "分类", photoName: "class_white", selectName: "class_red");
        
        let circleVC = CircleViewController.init();
        self.createController(vc: circleVC, title: "圈子", photoName: "circle", selectName: "circle");
        
        let shopCart = ShoppingCartController.init();
        self.createController(vc: shopCart, title: "购物车", photoName: "shopping_white", selectName: "shopping_red");
        
        let myVC = MyViewController.init();
        self.createController(vc: myVC, title: "我的", photoName: "my_white", selectName: "my_red");
        
        
        
        //self.setViewControllers([homePage], animated: true);
        
        
    }
    
    func createController(vc:UIViewController,title:String,photoName:String,selectName:String) -> Void{
        let nav = UINavigationController.init(rootViewController: vc);
        nav.title = title;
        vc.tabBarItem.title = title;
        vc.tabBarItem.image = UIImage.init(named: photoName);
        vc.tabBarItem.selectedImage = UIImage.init(named: selectName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        self.addChildViewController(nav);
        
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
