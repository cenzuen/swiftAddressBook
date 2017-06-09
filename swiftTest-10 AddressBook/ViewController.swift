//
//  ViewController.swift
//  swiftTest-10 AddressBook
//
//  Created by joey0824 on 2017/5/24.
//  Copyright © 2017年 JC. All rights reserved.
//

import UIKit
import LKDBHelper
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    
    var dataArr:[contactDBModel]? = nil
    
    lazy var items : [String]? = {
        () -> [String]? in
        
        guard let result = contactDBModel.search(withSQL: "select from contact") else{
            return nil
        }
        
        return result as? [String]
    }()
    
    var helper:LKDBHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "联系人列表"
        
        
        
        self.helper = contactDBModel.getUsingLKDBHelper()
        
        setupTableView()
        
        setupNaviItem()
        
        print(NSHomeDirectory())
        
//        self.loadData { (dataArr) in
//            contactDBModel.getCreateTableSQL()
//            contactDBModel.insertArrayByAsync(toDB: dataArr)
//            self.dataArr = dataArr
//            self.tableView?.reloadData()
//            
//            
//        }
        
        
//        var contact = contactDBModel(name: "haha", phoneNum: "1211222")//contactModel.init(name: "haha", phoneNum: "121222")
        
//        guard let name = contact.name,let phoneNum = contact.phoneNum else {
//            return
//        }
//        print(name,phoneNum)
        
        
 
        
       
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    //MARK: - tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard (dataArr?.count) != nil else {
            return 0
        }
        return (dataArr?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellId")
        
        
//        let dataa:contactDBModel = (dataArr?[indexPath.row])!
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        }
        
        guard let data = dataArr?[indexPath.row] else {
            return cell!
        }
        cell?.textLabel?.text = data.name
        
        cell?.detailTextLabel?.text = data.phoneNum
        return cell!
    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellId")
//        
//        if cell == nil {
//            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
//           // cell = Bundle.main.loadNibNamed("testCell", owner: nil, options: nil)?.last as? UITableViewCell
//        }
//        cell?.textLabel?.text = "\(indexPath.row)"
// 
//        return cell!
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC:detailViewController = detailViewController()
        
        detailVC.contact = (dataArr?[indexPath.row])!
        
        detailVC.saveContact = {
            (contact:contactDBModel) in
            
            contactDBModel.insert(toDB: contact)
            
        }
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }


    //tabelView
    func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.center = view.center
        tableView?.delegate = self
        tableView?.dataSource = self
//        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")

        view.addSubview(tableView!)
    }
    
    //NaviItem
    func setupNaviItem() {
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchupAdd))
        
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func touchupAdd() {
        
        let detailVC = detailViewController()
        
        detailVC.saveContact = {
        
            (contact:contactDBModel) in
            
            self.dataArr?.append(contact)
            
            self.tableView?.reloadData()
            
        }
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    private func loadData(competion:@escaping (_ list:[contactDBModel])->()) {
        DispatchQueue.global().async {
            
            print("正在努力jiaz")
//            Thread.sleep(forTimeInterval: 1)
            var arrayM = [contactDBModel]()
            
            for i in 0..<20 {
                var contact = contactDBModel.init(name: "客户\(i)", phoneNum: "1860"+String(format: "%06d", arc4random_uniform(100000)))//contactModel.init(name: "客户\(i)", phoneNum: "1860"+String(format: "%06d", arc4random_uniform(100000)))
                //let contact = contactDBModel(name: "客户\(i)", phoneNum: "1860"+String(format: "%06d", arc4random_uniform(100000)))//contactModel.init(name: "客户\(i)", phoneNum: "1860"+String(format: "%06d", arc4random_uniform(100000)))
                
                arrayM.append(contact)
            }
            
            DispatchQueue.main.async(execute: { 
                
                competion(arrayM)
                
                
            })
            
        }
    }
    
    
}

