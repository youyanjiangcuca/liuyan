//
//  MainScrollViewController.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/3/6.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit
import Kingfisher
class MainScrollViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataDic = NSDictionary()
    var table:UITableView!
    let footer = MJRefreshBackNormalFooter()
    var page = 1
    var dataArr = NSMutableArray()
    var headerView:UIImageView?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = (self.dataDic["link_name"] as! String)
        print(self.dataDic)
        self.view.backgroundColor = UIColor.white
        self.createTable()
        self.getMoreData()
        
    }
    func createTable() -> Void {
        
        self.table = UITableView.init(frame: CGRect.init(x: 0, y: CGFloat(NAVHEIGHT), width: SCREEN_WIDTH, height: SCREEN_HEIGHT-CGFloat(NAVHEIGHT+25)), style: UITableViewStyle.plain)
        self.table.delegate = (self as UITableViewDelegate)
        self.table.dataSource = (self as UITableViewDataSource)
        self.table.separatorStyle = UITableViewCellSeparatorStyle.none
        self.table.rowHeight = 100
        self.table.register(MainScrollCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.table)
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(getMoreData))
        self.table.mj_footer = footer
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MainScrollCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainScrollCell
        
        let cellData = self.dataArr[indexPath.row] as! NSDictionary
        cell.setData(dic: cellData)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if self.headerView == nil {
            self.headerView = UIImageView()
            let str = self.dataDic["image_url"] as! String
            let urlStr = String(HttpManager.ERPBaseUrl+str)
            self.headerView?.kf.setImage(with: ImageResource.init(downloadURL: URL(string: urlStr)!), placeholder: nil, options: nil, progressBlock: nil) { (image, error, type, url) in
                
            }
        }
        
        return self.headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击的是第"+String(indexPath.row)+"行")
    }
    @objc func getMoreData() -> Void {
        print("执行刷新方法")
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {
//            self.table.mj_footer.endRefreshing()
//        })
        
        let para = NSMutableDictionary()
        
        let topic_id = self.dataDic["link_url"] as! String
        para["topic_id"] = topic_id
        para["page_size"] = 10
        para["page"] = self.page
        
        HttpManager.postERPUrl(url: "business.topic.skus", para: para) { (response) in
            print(response)
            let result = response["code"] as! String
            
            if result == "success"
            {
                print("成功")
                
                let body = response["body"] as! NSDictionary
                let skus = body["skus"] as! NSArray
                if skus.count > 0 {
                    self.dataArr.addObjects(from: skus as! [Any])
                    self.page = self.page + 1
                    self.table.reloadData()
                }
                
            }
            else
            {
                print("失败")
            }
            
            self.table.mj_footer.endRefreshing()
            
        }
        
    }
    func getImageSize() -> Void {
        
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
extension MainScrollViewController{
    
}
