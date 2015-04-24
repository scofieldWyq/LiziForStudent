//
//  LiziMyNotifications.h
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/24.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LiziMyNotification;

@interface LiziMyNotifications : NSObject
@property (nonatomic, strong) NSMutableArray *myNotifications;
+ (LiziMyNotifications *)Noti;

- (void)addOneAlarm:(LiziMyNotification *)ln;
- (void)removeOneAlarm:(LiziMyNotification *)ln;
@end
