//
//  alarmViewController.m
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "alarmViewController.h"
@interface alarmViewController()
@property (weak, nonatomic) IBOutlet UITableView *alarmTableList;
@end
@implementation alarmViewController
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"alarm");
}
@end
