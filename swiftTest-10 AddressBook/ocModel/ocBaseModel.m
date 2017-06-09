//
//  ocBaseModel.m
//  swiftTest-10 AddressBook
//
//  Created by joey0824 on 2017/6/6.
//  Copyright © 2017年 JC. All rights reserved.
//

#import "ocBaseModel.h"
#import "LKDBHelper.h"
@implementation ocBaseModel

+ (LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;

        
        dispatch_once(&onceToken, ^{
            NSString *sqlitePath = [ocBaseModel downloadPath];
            NSString *dbpath = [sqlitePath stringByAppendingPathComponent:[NSString stringWithFormat:@"JCMsgDB.db"]];
            db = [[LKDBHelper alloc]initWithDBPath:dbpath];
            
        });

    return db;
}

+ (NSString *)downloadPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *downloadPath = [documentPath stringByAppendingString:@""];
    
    NSLog(@"downloadPath = %@---",downloadPath);
    
    return downloadPath;
}

+(NSString *) getHello
{
    NSString *hello = @"hello";
    
    return hello;
}

+(void)dbDidCreateTable:(LKDBHelper*)helper tableName:(NSString*)tableName
{
    NSLog(@"createTableName:%@ ----",tableName);
}

@end

@implementation NSObject(PrintSQL)

/**
 *  创建数据表
 */
+(NSString *)getCreateTableSQL
{
    LKModelInfos* infos = [self getModelInfos];
    NSString* primaryKey = [self getPrimaryKey];
    NSMutableString* table_pars = [NSMutableString string];
    for (int i=0; i<infos.count; i++) {
        
        if(i > 0)
            [table_pars appendString:@","];
        
        LKDBProperty* property =  [infos objectWithIndex:i];
        [self columnAttributeWithProperty:property];
        
        [table_pars appendFormat:@"%@ %@",property.sqlColumnName,property.sqlColumnType];
        
        if([property.sqlColumnType isEqualToString:LKSQL_Type_Text])
        {
            if(property.length>0)
            {
                [table_pars appendFormat:@"(%ld)",(long)property.length];
            }
        }
        if(property.isNotNull)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_NotNull];
        }
        if(property.isUnique)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_Unique];
        }
        if(property.checkValue)
        {
            [table_pars appendFormat:@" %@(%@)",LKSQL_Attribute_Check,property.checkValue];
        }
        if(property.defaultValue)
        {
            [table_pars appendFormat:@" %@ %@",LKSQL_Attribute_Default,property.defaultValue];
        }
        if(primaryKey && [property.sqlColumnName isEqualToString:primaryKey])
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_PrimaryKey];
        }
    }
    NSString* createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",[self getTableName],table_pars];
    return createTableSQL;
}



@end
