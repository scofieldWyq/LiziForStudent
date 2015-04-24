//
//  LiziAlarmAdd.h
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/24.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LiziNotificationDetail;
@protocol updateView<NSObject>
@optional
- (void)updateTableViewData;
@end
@interface LiziAlarmAdd : UIViewController
@property (nonatomic, strong) LiziNotificationDetail *notificationDetailAdd;
@property (nonatomic, strong) id<updateView> del;
- (void)setDataDelegate:(id)dele;
@end
