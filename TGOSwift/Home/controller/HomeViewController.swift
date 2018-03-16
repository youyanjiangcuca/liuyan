//
//  HomeViewController.swift
//  TGOSwift
//
//  Created by 家乐淘 on 2018/1/17.
//  Copyright © 2018年 家乐淘. All rights reserved.
//

import UIKit
import Kingfisher
class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MainScrollDelegate,SortScrollViewDelegate {
    var firstHeaderView : UICollectionReusableView?
    var homeData:NSDictionary!
    var mainScroll : MainScroll?
    var sortScroll :SortScrollView?
    var collectionView : UICollectionView?
    var mainScrollData : NSArray?
    var sortScrollData = NSArray()
    var leftDic : NSDictionary!
    var rightDic : NSDictionary!
    var everySpecialData = NSDictionary()
    var weekHotSellData = NSDictionary()
    var homePageCellData = NSArray()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.title = "首页"
        
        //self.createTable()
        self.getHomeData()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
//            //code
//            self.getSortData()
//            print("10 秒后输出")
//        }
        self.getSortData()
        self.createNavigation();
    }
    
    //MARK:-创建表格
    func createTable() -> Void {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SCREEN_WIDTH/2-15, height: 220)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom:6, right: 10)
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-CGFloat(TABBARHEIGHT)),collectionViewLayout:layout)
        
        self.collectionView?.delegate = self as UICollectionViewDelegate
        self.collectionView?.dataSource = self as UICollectionViewDataSource
        self.collectionView?.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        self.collectionView?.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView1")
        
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView2")
        
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView3")
        
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView4")
        
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView5")
        
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView")
        
        self.collectionView?.backgroundColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
        self.view.addSubview(self.collectionView!)
        
    }
    //返回区的数量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    //返回每个区cell的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < 5
        {
            return 0
        }
        return  10
    }
    //返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "cell"
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomePageCollectionViewCell
        let dicData = self.homePageCellData[indexPath.row] as! NSDictionary
        cell.setData(dic: dicData)
        cell.backgroundColor = UIColor.white
        return cell
        
    }
    //返回区头和区脚
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "UICollectionElementKindSectionHeader" {

            if indexPath.section == 0{
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier:"headerView" , for: indexPath)

                return self.createScroll(view: headerView)
            }
                
            else if indexPath.section == 1{
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader , withReuseIdentifier:"headerView1" , for: indexPath)
                
                return self.createSortView(view: headerView)
            }
                
            else if indexPath.section == 2{
                
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader , withReuseIdentifier:"headerView2" , for: indexPath)
                
                return self.createTodaySpecial(view: headerView)
            }
            
            else if indexPath.section == 3{
                
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView3", for: indexPath)
                
                return self.createEverySpecialView(view: headerView)
            }
                
            else if indexPath.section == 4{
                
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView4", for: indexPath)
                
                return self.createWeekHotSellView(view: headerView)
            }
            
            else if indexPath.section == 5{
                
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView5", for: indexPath)
                
                return self.createRecommendView(view: headerView)
                
            }
            
        }
//        else
//        {
//            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath)
//            footerView.backgroundColor = UIColor.red
//            return footerView
//        }
        return UICollectionReusableView()
    }
    //返回区头的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0
        {
            return CGSize.init(width: SCREEN_WIDTH, height: 245)
        }
        else if section == 1
        {
            if self.sortScrollData.count == 0
            {
                return CGSize.zero
            }
            return CGSize.init(width: SCREEN_WIDTH, height: 160)
        }
        else if section == 2
        {
            return CGSize.init(width: SCREEN_WIDTH, height: 120)
        }
        else if section == 3
        {
            return CGSize.init(width:SCREEN_WIDTH, height:220)
        }
        else if section == 4
        {
            return CGSize.init(width: SCREEN_WIDTH, height: 440)
        }
        else if section == 5
        {
            return CGSize.init(width: SCREEN_WIDTH, height: 40)
        }
        return CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
        //return CGSize.init(width: SCREEN_WIDTH, height: 5)
    }
    //MARK:-获取首页数据
    func getHomeData() -> Void {
        
        let para = NSMutableDictionary()
        para["spcode"] = SPCODE
        para["home_id"] = HOME_ID
        HttpManager.postERPUrl(url: "business.app.home", para: para) { (response) in
            //print(response)
            let dic = response["body"] as! NSDictionary
            self.homeData = dic
            let arr = dic["banners"] as! NSArray
            self.mainScrollData = arr
            let linkArr = dic["links"] as! NSArray
            for linkD in linkArr{
                let linkDic = linkD as! NSDictionary
                let position = linkDic["position"] as! String
                if position == "3"{
                    let ranks = linkDic["ranks"] as! String
                    if ranks == "1"{
                        self.leftDic = linkDic
                    }
                    else
                    {
                        self.rightDic = linkDic
                    }
                }
                else if position == "2"
                {
                    self.everySpecialData = linkDic
                }
                else if position == "4"
                {
                    self.weekHotSellData = linkDic
                }
                else if position == "6"
                {
                    self.homePageCellData = linkDic["list"] as! NSArray
                }
            }
            
            self.createTable()
            
        }
    }
    //MARK:-获取首页分类
    func getSortData() -> Void {
        let para = NSMutableDictionary.init()
        para["spcode"] = SPCODE
        HttpManager.postERPUrl(url: "goods.categories", para: para) { (response) in
            //print(response)
            let dic = response["body"] as! NSDictionary
            let arr = dic["categories"] as! NSArray
            self.sortScrollData = arr
            if self.collectionView != nil
            {
                self.collectionView?.reloadData()
            }
            
        }
        
    }
    //MARK:-创建首页轮播视图
    func createScroll(view:UICollectionReusableView) -> UICollectionReusableView {
        
        let headerView = view.viewWithTag(10)
        if headerView == nil
        {
            let dataArr = NSMutableArray()
            for dic in self.mainScrollData!
            {
                let dict = dic as! NSDictionary
                dataArr.add(dict["image_url"] as! String)
            }
            
            self.mainScroll = MainScroll.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 245))
            self.mainScroll?.tag = 10
            self.mainScroll?.bounces = true
            self.mainScroll?.isPagingEnabled = true
            self.mainScroll?.backgroundColor = UIColor.orange
            self.mainScroll?.dataArray = dataArr
            self.mainScroll?.contentSize = CGSize.init(width: CGFloat(dataArr.count)*SCREEN_WIDTH, height: (self.mainScroll?.bounds.size.height)!)
            self.mainScroll?.clickDelegate = self as MainScrollDelegate
            view.addSubview(self.mainScroll!)
        }
        return view
        
        
        
    }
    //MARK:-创建首页分类视图
    func createSortView(view:UICollectionReusableView) -> UICollectionReusableView {
        
        let headerView = view.viewWithTag(10)
        if headerView == nil
        {
            self.sortScroll = SortScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 160))
            self.sortScroll?.showsHorizontalScrollIndicator = false
            self.sortScroll?.dataArray = self.sortScrollData
            self.sortScroll?.clickDelegate = self as SortScrollViewDelegate
            self.sortScroll?.contentSize = CGSize.init(width:CGFloat(((self.sortScrollData.count-1)/8+1))*SCREEN_WIDTH, height:160 )
            self.sortScroll?.tag = 10
            self.sortScroll?.isPagingEnabled = true
            self.sortScroll?.bounces = false
            self.sortScroll?.backgroundColor = UIColor.white
            view.addSubview(self.sortScroll!)
        }
        
        return view
        
    }
    //MARK:-今日上新 每日推荐
    func createTodaySpecial(view:UICollectionReusableView) -> UICollectionReusableView {
        
        let subView = view.viewWithTag(10)
        
        if subView == nil
        {
            //创建视图
            let leftBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH/2, height: 120))
            let str = self.leftDic["image_url"] as? String
            
            let imageurl = URL(string:HttpManager.ERPBaseUrl+str!)
            
            leftBtn.kf.setBackgroundImage(with: ImageResource.init(downloadURL:imageurl!), for: UIControlState.normal)
            leftBtn.addTarget(self, action: #selector(newToday), for: UIControlEvents.touchUpInside)
            leftBtn.tag = 10
            
            view.addSubview(leftBtn)
            
            let rightBtn = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH/2, y: 0, width: SCREEN_WIDTH/2, height: 120))
            rightBtn.tag = 11
            let str2 = self.rightDic["image_url"] as? String
            
            let imageurl2 = URL(string:HttpManager.ERPBaseUrl+str2!)
            
            rightBtn.kf.setBackgroundImage(with: ImageResource.init(downloadURL:imageurl2!), for: UIControlState.normal)
            rightBtn.addTarget(self, action: #selector(newToday(sender:)), for: .touchUpInside)
            
            view.addSubview(rightBtn)
            
        }
        
        return view
    }
    //MARK:-天天特价
    func createEverySpecialView(view:UICollectionReusableView) -> UICollectionReusableView {
        
        let subView = view.viewWithTag(10)
        
        if subView == nil {
            //创建
            let special = EverySpecialView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 220))
            special.backgroundColor = UIColor.white
            special.tag = 10
            special.dataDic = self.everySpecialData
            view.addSubview(special)
        }
        return view
        
    }
    //MARK:-一周热销榜
    func createWeekHotSellView(view:UICollectionReusableView) -> UICollectionReusableView {
        
        let subview = view.viewWithTag(10)
        
        if subview == nil{
            
            let weekHotView = WeekSellHotView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 440))
            weekHotView.backgroundColor = UIColor.white
            weekHotView.tag = 10
            weekHotView.dataDic = self.weekHotSellData
            view.addSubview(weekHotView)
        }
        
        return view
        
    }
    //MARK:-推荐
    func createRecommendView(view:UICollectionReusableView) -> UICollectionReusableView {
        
        let subview = view.viewWithTag(10)
        
        if subview == nil{
            
            let view2 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
            view2.backgroundColor = UIColor.white
            view2.tag = 10
            view.addSubview(view2)
            
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
            label.text = "推荐"
            label.textAlignment = NSTextAlignment.center
            view2.addSubview(label)
        }
        
        return view
    }
    //MARK:-导航视图
    func createNavigation() -> Void {
        
        self.navigationController?.title = "首页";
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        let btn = UIButton.init();
        btn.addTarget(self, action: #selector(codeScanner), for: UIControlEvents.touchUpInside);
        btn.setImage(UIImage.init(named: "scan"), for: UIControlState.normal)
        let leftBtn = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = leftBtn
        
        let btnR = UIButton.init();
        btnR.addTarget(self, action: #selector(messageReceived), for: UIControlEvents.touchUpInside)
        btnR.setImage(UIImage.init(named: "message"), for: UIControlState.normal)
        let rightBtn = UIBarButtonItem.init(customView: btnR)
        self.navigationItem.rightBarButtonItem = rightBtn
        
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH-CGFloat(WIDTH(num: 120)), height: 30)
        view.alpha = 0.5
        view.layer.cornerRadius = 2
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        
        let label = UILabel.init(frame: CGRect(x: 30, y: 0, width: 200, height: 30))
        label.text = "请输入商品名称"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.left
        view.addSubview(label)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(goodsSearch))
        view.addGestureRecognizer(tap)
        
        self.navigationItem.titleView = view
        
    }
    
    //MARK:-今日上新
    @objc func newToday(sender:UIButton) -> Void {
        if sender.tag == 10{
            print("今日上新")
        }
        else{
            print("天天特价")
        }
        
    }
    //MARK:-二维码扫描
    @objc func codeScanner() -> Void {
        print("二维码扫描")
    }
    //MARK:-接收到的消息
    @objc func messageReceived() -> Void {
        print("消息界面")
    }
    //MARK:-商品搜索
    @objc func goodsSearch() -> Void {
        print("商品搜索界面")
    }
    func getMainScrollGoods(index: Int) {
        
        let dic = self.mainScrollData![index] as! NSDictionary
        let mainVC = MainScrollViewController()
        mainVC.dataDic = dic
        self.navigationController?.pushViewController(mainVC, animated: true)
        
    }
    func getDetailSort(dic:NSDictionary) {
        print(dic)
        let vc = KindViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
