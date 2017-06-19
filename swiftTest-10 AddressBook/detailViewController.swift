//
//  detailViewController.swift
//  swiftTest-10 AddressBook
//
//  Created by joey0824 on 2017/5/25.
//  Copyright © 2017年 JC. All rights reserved.
//

import UIKit

class detailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    typealias Handler = (_ contact:contactDBModel) -> Void
    
    var tableView:UITableView?
    
    var name:String?
    
    var phoneNum:String?
    
    var rightItem:UIBarButtonItem? = nil
    
    
    
    var contact:contactDBModel?{
        didSet{
            print(contact!)
            name = contact?.name
            phoneNum = contact?.phoneNum
        }
        
        
    }
    
    
    
    var saveContact:Handler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        setupItem()
        
        self.rightItem?.isEnabled = false
        
       NotificationCenter.default.addObserver(self, selector: #selector(textChange(noti:)), name: .UITextFieldTextDidChange, object: nil)
        
        
        
        
      
    }
    
    func textChange(noti:Notification) {
        
        
        
        let textField = noti.object as? UITextField
        
        print(textField!)
        
        if contact == nil {
            //self.contact = contactDBModel(name: "", phoneNum: "")
        }
        
        if textField?.tag == 1 {
            
            self.contact?.name = textField?.text
            self.name = textField?.text
            print("tag1:\(textField?.text ?? "noData")")
        }
        
        else if textField?.tag == 2{
            self.contact?.phoneNum = textField?.text
            self.phoneNum = textField?.text
            print("tag2:\(textField?.text ?? "noData")")
        }
        
        print("name:\(name?.characters.count ?? 0)")
        print("phoneNum:\(phoneNum?.characters.count ?? 0)")
        
        rightItem?.isEnabled = ((name?.characters.count ?? 0) > 0 && (phoneNum?.characters.count ?? 0) > 0) ? true:false
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailTableViewCell.initCell(tableView: tableView)
        switch indexPath.row {
        case 0:
            
            cell.infoTextField.placeholder = "请输入联系人姓名"
            cell.infoTextField.text = self.contact?.name
            cell.infoTextField.tag = 1
            cell.infoTextField.delegate = self
            
          
        case 1:
            
            cell.infoTextField.placeholder = "请输入联系人电话号码"
            cell.infoTextField.text = self.contact?.phoneNum
            cell.infoTextField.tag = 2
            cell.infoTextField.delegate = self
            
            
            
        default:

            print("未找到")
            
            
        }
        
        return cell
    }
    

    func setupTableView() {
        
        self.tableView = UITableView(frame: self.view.bounds,style:.plain)
        
        self.tableView?.center = view.center
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .none
        
        
        view.addSubview(tableView!)
    }
    
    //MARK: item
    func setupItem() {
        self.rightItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveClick))
        
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    func saveClick() {
        
        saveContact?(self.contact!)
        
        self.navigationController?.popViewController(animated: true)
    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}
