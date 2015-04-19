//
//  NUPTLoginPage.m
//  LiziPage
//
//  Created by 吴英强 on 15/3/16.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "NUPTLoginPage.h"
#import "NUPTChangePhoneInformation.h"
#import "Tools.h"
#import "LiziColor.h"
#import "mainViewController.h"
#import "LiziHttpRequired.h"
#import "LiziCheckStatusCode.h"

//#import "NUPTStudent.h"

@interface NUPTLoginPage() <UITextFieldDelegate, dataReceive>

@property (nonatomic, weak) IBOutlet UIView *customeView;
@property (nonatomic, weak) IBOutlet UIView *changePhoneNumberView;
@property (nonatomic, weak) IBOutlet UITextField *phone;
@property (nonatomic, weak) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UIButton *changePhoneButton;

@property (nonatomic, strong) UIActivityIndicatorView *progress;
@end
@implementation NUPTLoginPage

- (IBAction)changePhoneNumber:(UIButton *)sender {
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    
    [backItem setTitle:@"手机变更"];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    NUPTChangePhoneInformation *cpv = [[NUPTChangePhoneInformation alloc] init];
    
    [Tools pushView:cpv from:self];
    
}


//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    
//    return YES;
//}
-(void)viewDidLoad
/*
 * when view load, will called this method
 */
{
    
    [super viewDidLoad];
    
    
    /* prepare for view in custome. */
    [Tools prepareCustomeView:_customeView
     forAttantion:NO];
    [Tools prepareCustomeView:_changePhoneNumberView
     forAttantion:YES];
    [Tools prepareCustomeTextField:_phone delegate:self withLeftView:nil];
    [Tools prepareCustomeTextField:_code delegate:self withLeftView:nil];
    
    /* set background */
    [self.view setBackgroundColor:[LiziColor backgroundColor]];
    
    /* set some property. */
    [_phone setPlaceholder:@"手机"];
    [_code setPlaceholder:@"短信码"];
    
}
-(IBAction)getMessageCode:(UIButton *)sender
/*
 * this method will get the message code
 * No operation.
 */
{

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please check your phone" delegate:self cancelButtonTitle:nil otherButtonTitles:@"sure", nil];
    [alert show];
    
}


-(IBAction)completeLogin:(UIButton *)sender
/*
 * when edit completed, and send the login data to server.
 * get data from server, and fill the student class.
 */
{

    /* end editing in window, let to start app. */
    [self.view endEditing:YES];
    
    /* check the text is fill or not */
    if([_phone.text isEqual:@""] || [_code.text isEqual:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong" message:@"You have to fill it all" delegate:self cancelButtonTitle:nil otherButtonTitles:@"sure", nil];
        
        [alert show];
        return ;
    }
    
        /*
         * test here
         */
        NSLog(@"phone: %@", _phone.text);
        NSLog(@"password: %@", _code.text);
        /*
         * test prints phone number, code
         */
 
    
    /* get the student information */
    [LiziHttpRequired getInstance].dataDelegate = self;
    [[LiziHttpRequired getInstance] loginNowWithName:_phone.text password:_code.text viewController:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (BOOL)checkPhase
/*
 * 1,check the data which get from server
 * 2,fill the student instance.
 * 3, return status.
 */
{
    
    /* check the status code */
    if( [LiziCheckStatusCode checking:[LiziHttpRequired getInstance].getData[@"status"]]){
        
        /* fill student instance data */
        return YES;
    }
    
    return NO;
}

- (void)loginCompleted {
    NSLog(@"%@", [[LiziHttpRequired getInstance] getData ]);
    NSLog(@"login complete ");
    
    /* check */
    if([self checkPhase])
    {
        /* if check is success, jump to main page */
        mainViewController *mainPage = [[mainViewController alloc] init];
        
        [Tools pushView:mainPage from:self];
        
    }
    
    return ;
}

@end
