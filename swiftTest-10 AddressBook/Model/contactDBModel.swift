//
//  contactDBModel.swift
//  swiftTest-10 AddressBook
//
//  Created by joey0824 on 2017/6/7.
//  Copyright © 2017年 JC. All rights reserved.
//

import UIKit

class contactDBModel: ocBaseModel {

    var contactID:Int = 0
    
    var name:String?
    
    var phoneNum:String?
    
    
    init(name:String,phoneNum:String) {
        
        
        self.name = name
        self.phoneNum = phoneNum
        super.init()
        
    }
    
    override class func getPrimaryKey() -> String {
        return "contactID"
    }
    override class func getTableName() -> String {
        return "contactList"
    }
    override class func isContainParent() -> Bool{
        return true
    }

}
