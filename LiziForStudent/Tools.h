//
//  Tools.h
//  Testing
//
//  Created by 吴英强 on 15/3/30.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
#pragma mark -
#pragma mark - navigation view push & pop
+ (void)pushView:(UIViewController *)pushViewController from:(UIViewController *)currentViewController ;
+ (void)popView:(UIViewController *)popViewController   from:(UIViewController *)currentViewController ;
#pragma mark -
#pragma mark - custome textField and view

/*  two parameters: view, yOrn
 view: the view of what you want to custome.
 yOrn:
 YES: the border line is not the same.
 NO:  the border line is the same.
 */
+ (void) prepareCustomeView:(UIView *)view
               forAttantion:(BOOL)yOrn;

+ (void)prepareCustomeTextField:(UITextField *)text
                       delegate:(id)del
                   withLeftView:(NSString *)imgName;

#pragma mark -
#pragma mark - send text content

+ (void)sendText:(UITextField *)text to:(id)who forProperty:(NSString *)p;
+ (void)saveData:(NSString *)data;

@end
