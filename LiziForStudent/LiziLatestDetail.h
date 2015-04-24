//
//  LiziLatestDetail.h
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/24.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiziLatestDetail : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tv;
- (void)showingNowWithData:(NSArray *)titles;
@end
