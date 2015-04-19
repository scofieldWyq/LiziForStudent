//
//  UIViewController+mainViewControllerInstance.m
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "UIViewController+mainViewControllerInstance.h"
#import "mainViewController.h"

@implementation UIViewController (mainViewController)

- (mainViewController *)detailController {
    UIViewController *superVC = self.parentViewController;
    
    if([superVC isKindOfClass:[mainViewController class]]) {
        
        return (mainViewController *)superVC;
    }
    
    return nil;
}

@end
