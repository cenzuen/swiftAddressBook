//
//  ocBaseModel.h
//  swiftTest-10 AddressBook
//
//  Created by joey0824 on 2017/6/6.
//  Copyright © 2017年 JC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LKDBHelper;
@interface ocBaseModel : NSObject


+ (LKDBHelper *)getUsingLKDBHelper;
@end
