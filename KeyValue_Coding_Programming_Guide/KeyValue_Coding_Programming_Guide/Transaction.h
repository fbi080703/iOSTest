//
//  Transaction.h
//  KeyValue_Coding_Programming_Guide
//
//  Created by Apple on 15/8/29.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

/***  名称*/
@property (nonatomic, strong) NSString *payee;

/***  金额*/
@property (nonatomic, assign) double amount;

/***  日期*/
@property (nonatomic, strong) NSDate *date;

@end
