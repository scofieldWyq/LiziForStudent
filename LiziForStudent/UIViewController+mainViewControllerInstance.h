//
//  UIViewController+mainViewControllerInstance.h
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class mainViewController;
@interface UIViewController(mainViewController)
@property (nonatomic, strong, readonly) mainViewController *detailController;
@end
