//
//  Tools.m
//  Testing
//
//  Created by 吴英强 on 15/3/30.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+ (void)pushView:(UIViewController *)pushViewController from:(UIViewController *)currentViewController {
    [currentViewController.navigationController pushViewController:pushViewController animated:YES];
    
}

+ (void)popView:(UIViewController *)popViewController from:(UIViewController *)currentViewController {
    [currentViewController.navigationController popToViewController:popViewController animated:YES];
}

+ (void) prepareCustomeView:(UIView *)view
               forAttantion:(BOOL)yOrn{
    float left_right_side = 0.5;
    float top_bottom_side = 2;
    
    if(yOrn){
        top_bottom_side = left_right_side;
    }
    [view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    UIView *insideView =[[UIView alloc] initWithFrame:CGRectMake(left_right_side, top_bottom_side, view.frame.size.width - left_right_side * 2, view.frame.size.height - top_bottom_side * 2)];
    
    [insideView setBackgroundColor:[UIColor whiteColor]];
    
    [view insertSubview:insideView atIndex:0];
    
}

+ (void)prepareCustomeTextField:(UITextField *)text
                       delegate:(id)del
                   withLeftView:(NSString *)imgName

{
    
    //set the style to empty.
    [text setBorderStyle:UITextBorderStyleNone];
    
    //add a line at the bottom of the text field.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, text.frame.size.height - 2, text.frame.size.width, 2)];
    
    view.alpha = 0.5;
    view.backgroundColor = [UIColor grayColor];
    
    [text addSubview:view];
    text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    text.clearButtonMode = UITextFieldViewModeAlways;
    
    if(imgName){
        UIImage *img = [UIImage imageNamed:imgName];
        
        CGRect pos = CGRectMake(0, 0, 20,  20);
        
        UIImageView *ImgText = [[UIImageView alloc] initWithFrame:pos];
        ImgText.image = img;
        
        //    ImgText.layer.cornerRadius = ImgText.frame.size.width / 2 ;
        //    ImgText.layer.borderWidth = 3.0f;
        //    ImgText.layer.borderColor = [UIColor grayColor].CGColor;
        //    ImgText.clipsToBounds = YES;
        
        text.leftView = ImgText;
        text.leftViewMode = UITextFieldViewModeAlways;
        
    }
    
    [text setDelegate:del];
    
}

@end
