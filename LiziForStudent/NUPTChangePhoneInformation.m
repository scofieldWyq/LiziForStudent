//
//  NUPTChangePhoneInformation.m
//  LiziPage
//
//  Created by 吴英强 on 15/3/16.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "NUPTChangePhoneInformation.h"
#import "Tools.h"
//#import "mainViewController.h"
#import "LiziHttpRequired.h"


@interface NUPTChangePhoneInformation() <dataReceive>
@end
@implementation NUPTChangePhoneInformation

- (void)prepareView{
    if( ! _sendEmailView && ! _updateInfoView) {
        [[NSBundle mainBundle] loadNibNamed:@"changeInforViews" owner:self options:nil];
        
        [self.view addSubview:_sendEmailView];
        [self.view addSubview:_updateInfoView];
        
    }
}

- (void)loadView {
   
    [super loadView];
    [self prepareView];
    [self setEmailText:_email newPhoneText:_Phone code:_changedCode];
    
    if(_updateInfoView){
        _updateInfoView.hidden = YES;
    }
    
}

-(void)setEmailText:(UITextField *)email    newPhoneText:(UITextField *)newPhone    code:(UITextField *)changeCode
/* custome text field.
 *
 */
{
    
    /* custome size */
    [Tools prepareCustomeTextField:email delegate:self withLeftView:@"email"];
    [Tools prepareCustomeTextField:newPhone delegate:self withLeftView:@"account"];
    [Tools prepareCustomeTextField:changeCode delegate:self withLeftView:@"number"];
    
    /* set placeholder */
    [email setPlaceholder:@" 邮箱"];
    [newPhone setPlaceholder:@"新手机"];
    [changeCode setPlaceholder:@"变更码"];
    
}

- (IBAction)sendCode:(UIButton *)sender
/* send the email to server 
 * that you want to change 
 * you phone number 
 */
{
    
    /* hide keyboard */
    [self.view endEditing:YES];
    
    /* check the email isn't empty */
    if([_email.text isEqual:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong" message:@"You have to fill it " delegate:self cancelButtonTitle:nil otherButtonTitles:@"sure", nil];
        
        [alert show];
        
        return ;
    }
    
    /* send the code to server 
     * show the next view.
     */
    [self sendCodeToServer];
    
    [UIView animateWithDuration:0.5 animations:^{
        [_sendEmailView setHidden:YES];
    } completion:^(BOOL finished) {
        [_updateInfoView setHidden:NO];
    }];
    
}

- (void)sendCodeToServer
/* send change phone number 
 * to server.
 */
{
    // send p< _email.text >
}

- (IBAction)completeLogin:(UIButton *)sender
/* login phase.
 * send the change phone number and code.
 */
{

    /* hide the keyboard */
    [self.view endEditing:YES];
    
    /* chekc the text isn't empty. */
    if( [_Phone.text isEqual:@""] || [_changedCode.text isEqual:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong" message:@"You have to fill it all" delegate:self cancelButtonTitle:nil otherButtonTitles:@"sure", nil];
        
        [alert show];
        
        return ;
    }
    
    /* send data to server */
    [LiziHttpRequired getInstance].dataDelegate = self;
    [[LiziHttpRequired getInstance] loginNowWithName:_Phone.text password:_changedCode.text viewController:self];
    
    //all thing is completed.
    
//    [self.navigationController.navigationBar setHidden:YES];
//    mainViewController *mainPage = [[mainViewController alloc] init];
    
//    [Tools pushView:mainPage from:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

- (void)loginCompleted {
    NSLog(@"data complete!");
}
@end
