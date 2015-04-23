//
//  NUPTRegisterPage.m
//  LiziPage
//
//  Created by 吴英强 on 15/3/16.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "NUPTRegisterPage.h"
#import "Tools.h"
#import "LiziStudent.h"
#import "LiziColor.h"
#import "LiziCheckStatusCode.h"
#import "mainViewController.h"

@implementation NUPTRegisterPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* prepare all the text field */
    [self prepare];
    
    /* set background */
    [self.view setBackgroundColor:[LiziColor backgroundColor]];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _registerView.hidden = NO;
    _registerDetailView.hidden = YES;
    
}

- (void)prepare
/*
 * custome text field.
 */
{
    
    [Tools prepareCustomeTextField:_name delegate:self withLeftView:nil];
    [_name setPlaceholder:@"姓名"];
    
    [Tools prepareCustomeTextField:_school delegate:self withLeftView:nil];
     [_school setPlaceholder:@"学校"];
    
    [Tools prepareCustomeTextField:_number delegate:self withLeftView:nil];
     [_number setPlaceholder:@"学号"];
    
    [Tools prepareCustomeTextField:_email delegate:self withLeftView:nil];
     [_email setPlaceholder:@"邮箱"];
    
    [Tools prepareCustomeTextField:_messageCode delegate:self withLeftView:nil];
     [_messageCode setPlaceholder:@"短信码"];
    
    [Tools prepareCustomeTextField:_phone delegate:self withLeftView:nil];
     [_phone setPlaceholder:@"手机号"];
    
    [Tools prepareCustomeView:_registerView forAttantion:NO];
    [Tools prepareCustomeView:_registerDetailView forAttantion:NO];
    
}

- (IBAction)getCode:(id)sender
/*
 * this method will get the message code
 * No operation.
 */
{
    /* hide keyboard */
    [self.view endEditing:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please check your phone" delegate:self cancelButtonTitle:nil otherButtonTitles:@"sure", nil];
    [alert show];
    
}

- (IBAction)completeRegister:(UIButton *)sender
/*
 * complete register.
 * and auto login.
 */
{
    /* hide the keyboard */
    [self.view endEditing:YES];
    
    /* check all the text is empty or not */
    if( [_name.text isEqualToString:@""] || [_school.text isEqualToString:@""] || [_number.text isEqualToString:@""] || [_email.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong" message:@"You have to fill it all" delegate:self cancelButtonTitle:nil otherButtonTitles:@"sure", nil];
        
        [alert show];
        return ;
    }
    
//    /* register now */
//    [[LiziHttpRequired getInstance] registerNowWithPhone:_phone.text code:_messageCode.text name:_name.text email:_email.text device:@".iphone." viewController:self ];
//    
//    /* check if register success or not */
//    if( [LiziCheckStatusCode checking:[LiziHttpRequired getInstance].getData[@"status"]]){
//    /* login now */
//        
//        [[LiziHttpRequired getInstance] loginNowWithName:_phone.text password:_messageCode.text  viewController:self];
    
        [self settingAlltheData];
        
            [self.navigationController.navigationBar setHidden:YES];
    
            mainViewController *mainPage = [[mainViewController alloc] init];
        
            [Tools pushView:mainPage from:self];
    //}
}

- (void)settingAlltheData
/*
 * setting all the student data.
 */
{
    LiziStudent *student = [LiziStudent me];
    [student templation];
    
    [student setName:self.name.text];
    [student setPhone:self.phone.text];
    [student setSchool:self.school.text];
    [student setNumber:self.number.text];
    [student setEmail:self.email.text];
    //
}

-(IBAction)nextStep:(UIButton *)sender
/*
 * show the next step.
 */
{
    /* hide keyboard */
    [self.view endEditing:YES];
    
    /* check the text is empty or not */
    // ( <_phone> || <_messageCode> )
    if([_phone.text isEqual:@""] || [_messageCode.text isEqual:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong" message:@"You have to fill it all" delegate:self cancelButtonTitle:nil otherButtonTitles:@"sure", nil];
        
        [alert show];
        return ;
    }
    
    /* show next, hide first page */
    [UIView animateWithDuration:0.5 animations:^{
        _registerView.hidden = YES;
        
    } completion:^(BOOL finished) {
        _registerDetailView.hidden = NO;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

- (void)registerCompleted {
    NSLog(@"register complete");
}
@end
