//
//  settingViewController.m
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "settingViewController.h"
#import "UIViewController+mainViewControllerInstance.h"
#import "mainViewController.h"
//#import "icon.h"
#import "LiziColor.h"

@interface settingViewController() <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *buttonSelected3;
@property (weak, nonatomic) IBOutlet UIButton *buttonSelected2;
@property (weak, nonatomic) IBOutlet UITextField *myIdea;
@property (weak, nonatomic) IBOutlet UIButton *buttonSelected1;

@property (strong, nonatomic) IBOutlet UIView *ideaView;
@property (weak, nonatomic) IBOutlet UIImageView *notificationState;
@property (weak, nonatomic) IBOutlet UIImageView *send_completed;

@property (nonatomic) BOOL notification;
@property (nonatomic) BOOL quitOff;
@property (nonatomic) float ideaCenterX;
@property (nonatomic) float ideaCenterY;
@property (nonatomic) float ideaCenterHideX;
@property (nonatomic) float ideaCenterHideY;
@end
@implementation settingViewController

- (instancetype)init {
    self = [super init];
    
    if(self) {
        _notification = NO;
        _quitOff = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];

    /* prepare for three button */
    [_buttonSelected1 setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateHighlighted];
    [_buttonSelected2 setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateHighlighted];
    [_buttonSelected3 setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateHighlighted];
    
    _ideaCenterX = self.view.center.x;
    _ideaCenterY = self.view.center.y;
    _ideaCenterHideX = ( _ideaCenterX + _ideaView.frame.size.width );
    _ideaCenterHideY =  _ideaCenterY ;
    
    /* hide something */
    [self.send_completed setHidden:YES];
    [self.send_completed setAlpha:1.0];
    
    /* set background */
    [self.view setBackgroundColor:[LiziColor backgroundColor]];
    
    /* prepare idea view */
    _ideaView.center = CGPointMake(_ideaCenterHideX, _ideaCenterHideY);
    [self.view addSubview:_ideaView];
    
    [_ideaView setHidden:YES];// hide idea view .
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* end edit */
    [self.view endEditing:YES];
    
}

- (IBAction)quit:(id)sender
/*
 * quit button.
 */
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认退出 ?" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    
    [alert show];
}
- (IBAction)idea:(id)sender {

    /* setting navigation */
    [self.detailController setNavigationLeftItem:[UIImage imageNamed:@"back"] title:@"意见反馈" withLeftStatus:LeftItemActionIdeaViewBack];
    [self.detailController setNavigationRightItem:[UIImage imageNamed:@"send"] withRightStatus:RightItemActionSendMyIdea];
    
    /* show */
    [self showIdea];
    
}
- (void)back
/*
 * back to setting view 
 */
{
    /* end edit */
    [self.view endEditing:YES];
    
    /* hide idea view */
    [self hideIdea];
}
- (IBAction)nitification:(id)sender
/*
 * set the notification.
 */
{
   
    if( ! _notification ){
        
        /* set some notifivation here */
        // notification.
        NSLog(@"notification ");
        [_notificationState setImage:[UIImage imageNamed:@"on"]];
        _notification = YES;
    }
    else {
        
        [_notificationState setImage:[UIImage imageNamed:@"off"]];
        _notification = NO;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
/*
 * the deleaget of alert.
 */
{
    if( buttonIndex == 1){
        NSLog(@"quit out");
        exit(0);
    }
}

- (void)sendMyIdea
/*
 * send my idea to server.
 *
 * when the send action trigger, will call this method.
 */
{
    /* end edit */
    [self.view endEditing:YES];
    
    //send ...
    // send the slef.myIdea.text to server.
    // if send data to server success
    
    /* show the view and wate for 0.75 second, then hide.*/
    [self.send_completed setHidden:NO];
    
    [UIView animateWithDuration:3 animations:^{
        [self.send_completed setAlpha:0.0];
        
    } completion:^(BOOL finished) {
        [self.send_completed setHidden:YES];
        [self.send_completed setAlpha:1.0];
        
    }];
    
    NSLog(@"send idea");
    
    
}


- (void)showIdea {
    
    if( [_ideaView isHidden]){
        
        [_ideaView setHidden:NO];

        [UIView animateWithDuration:0.35 animations:^{
            
            self.ideaView.center = CGPointMake(_ideaCenterX, _ideaCenterY);
            
        } completion:^(BOOL finished) {
            [self.myIdea becomeFirstResponder];
        }];
    }
}

- (void)hideIdea {
    
    if( ! [_ideaView isHidden] ) {
        [UIView animateWithDuration:0.35 animations:^{
            self.ideaView.center = CGPointMake(_ideaCenterHideX, _ideaCenterHideY);
            
        } completion:^(BOOL finished) {
            [self.ideaView setHidden:YES];
        }];
    }
}
@end
