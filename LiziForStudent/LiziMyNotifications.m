//
//  LiziMyNotifications.m
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/24.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziMyNotifications.h"
#import "LiziMyNotification.h"

@implementation LiziMyNotifications
+ (LiziMyNotifications *)Noti{
    static LiziMyNotifications *n;
    
    if( !n){
        n = [[LiziMyNotifications alloc] init];
        n.myNotifications = [[NSMutableArray alloc] init];
    }
    
    return n;
}

- (void)addOneAlarm:(LiziMyNotification *)ln {
    [self.myNotifications addObject:ln];
    
}

- (void)removeOneAlarm:(LiziMyNotification *)ln {
    [self.myNotifications removeObject:ln];
}
@end
