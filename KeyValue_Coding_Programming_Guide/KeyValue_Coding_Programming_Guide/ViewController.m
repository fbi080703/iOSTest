//
//  ViewController.m
//  KeyValue_Coding_Programming_Guide
//
//  Created by Apple on 15/8/29.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "Transaction.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *transactions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //@avg
    NSNumber *transactionAverage=[self.transactions valueForKeyPath:@"@avg.amount"];
    
    NSLog(@"@avg---%0.f",[transactionAverage doubleValue]);
    
    //@count
    NSNumber *numberOfTransactions = [self.transactions valueForKeyPath:@"@count"];
    
    NSLog(@"@count---%ld",[numberOfTransactions integerValue]);
    
    //@max
    NSDate *latestDate = [self.transactions valueForKeyPath:@"@max.date"];
    
    NSLog(@"latestDate----%@",[latestDate description]);
    
    //@min
    NSDate *earliestDate = [self.transactions valueForKeyPath:@"@min.date"];
    
    NSLog(@"earliestDate----%@",[earliestDate description]);
    
    //@sum
    NSNumber *amountSum = [self.transactions valueForKeyPath:@"@sum.amount"];
    
    NSLog(@"@count---%ld",[amountSum integerValue]);

    
    //@distinctUnionOfObjects
    NSArray *distinctUnionOfObjects = [self.transactions valueForKeyPath:@"@distinctUnionOfObjects.payee"];
    
    //@unionOfObjects
    NSArray *unionOfObjects = [self.transactions valueForKeyPath:@"@unionOfObjects.payee"];
}

#pragma mark - setter and getter
- (NSArray *)transactions
{
    if (!_transactions) {
        //
        Transaction *tran0=[[Transaction alloc] init];
        tran0.payee=@"Green Power";
        tran0.amount=120;
        tran0.date=[NSDate date];
        
        Transaction *tran1=[[Transaction alloc] init];
        tran1.payee=@"Green Power";
        tran1.amount=150;
        tran1.date=[NSDate dateWithTimeInterval:-40000 sinceDate:[NSDate date]];
        
        Transaction *tran2=[[Transaction alloc] init];
        tran2.payee=@"Green Power";
        tran2.amount=170;
        tran2.date=[NSDate dateWithTimeInterval:-20000 sinceDate:[NSDate date]];
        
        Transaction *tran3=[[Transaction alloc] init];
        tran3.payee=@"Car Loan";
        tran3.amount=250;
        tran3.date=[NSDate dateWithTimeInterval:-30000 sinceDate:[NSDate date]];
        
        Transaction *tran4=[[Transaction alloc] init];
        tran4.payee=@"General Cable";
        tran4.amount=120;
        tran4.date=[NSDate dateWithTimeInterval:-50000 sinceDate:[NSDate date]];
        
        
        Transaction *tran5=[[Transaction alloc] init];
        tran5.payee=@"Mortgage";
        tran5.amount=1250;
        tran5.date=[NSDate dateWithTimeInterval:-70000 sinceDate:[NSDate date]];
        
        Transaction *tran6=[[Transaction alloc] init];
        tran6.payee=@"Animal Hospital";
        tran6.amount=600;
        tran6.date=[NSDate dateWithTimeInterval:-10000 sinceDate:[NSDate date]];
        
        
        Transaction *tran7=[[Transaction alloc] init];
        tran7.payee=@"Mortgage";
        tran7.amount=1250;
        tran7.date=[NSDate dateWithTimeInterval:-20000 sinceDate:[NSDate date]];
        
        Transaction *tran8=[[Transaction alloc] init];
        tran8.payee=@"General Cable";
        tran8.amount=120;
        tran8.date=[NSDate dateWithTimeInterval:-80000 sinceDate:[NSDate date]];
        
        _transactions=@[tran0,tran1,tran2,tran3,tran4,tran5,tran6,tran7,tran8];
       
    }
    return _transactions;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
