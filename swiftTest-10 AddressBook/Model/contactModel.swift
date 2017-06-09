//
//  contactModel.swift
//  swiftTest-10 AddressBook
//
//  Created by joey0824 on 2017/5/25.
//  Copyright © 2017年 JC. All rights reserved.
//

import UIKit

class contactModel: NSObject {

    var name:String?
    
    
    var phoneNum:String?
    
    
    
    init(name:String,phoneNum:String) {
        
        
        self.name = name
        self.phoneNum = phoneNum
        
     
    }
    
    
    
}
