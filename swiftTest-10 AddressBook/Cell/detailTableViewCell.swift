//
//  detailTableViewCell.swift
//  swiftTest-10 AddressBook
//
//  Created by joey0824 on 2017/5/25.
//  Copyright © 2017年 JC. All rights reserved.
//

import UIKit

class detailTableViewCell: UITableViewCell {

    @IBOutlet weak var infoTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    class func initCell(tableView:UITableView)-> detailTableViewCell {
        
        let ID = "detailCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? detailTableViewCell
    
        
        if cell == nil {
            let bundel = Bundle.main
            cell = bundel.loadNibNamed("detailTableViewCell", owner: nil, options: nil)?.last as? detailTableViewCell
            
        }
        
        return cell!
        
        
    }
    
    
   
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
