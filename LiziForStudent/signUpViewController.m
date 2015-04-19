//
//  signUpViewController.m
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "signUpViewController.h"
#import "UIViewController+mainViewControllerInstance.h"
#import "mainViewController.h"
#import "signUpCell.h"
#import "Tools.h"
//#import "icon.h"
#import "LiziColor.h"
#import "LiziStudent.h"

@interface signUpViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *signClassTableList;
@property (nonatomic, strong) NSArray *datas;
@property (weak, nonatomic) IBOutlet UIView *signView;
@property (strong, nonatomic) IBOutlet UIView *signInNow;


//sigh view
@property (weak, nonatomic) IBOutlet UIView *classInfo;
@property (weak, nonatomic) IBOutlet UIView *classNotification;
@property (weak, nonatomic) IBOutlet UIView *classSignIn;
@property (weak, nonatomic) IBOutlet UIView *students;

@property (nonatomic) float signViewCenterX;
@property (nonatomic) float signViewCenterHideX;
@property (weak, nonatomic) IBOutlet UIImageView *signIn_completed;


//class detail
@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *clasId;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *notificationUpdateTime;
@property (weak, nonatomic) IBOutlet UILabel *notificationDetail;


//sign code
@property (weak, nonatomic) IBOutlet UITextField *s1;
@property (weak, nonatomic) IBOutlet UITextField *s2;
@property (weak, nonatomic) IBOutlet UITextField *s3;
@property (weak, nonatomic) IBOutlet UITextField *s4;


//a variable that check the row is first row
@property (nonatomic) BOOL off_first_row;

// a feedBack button
@property (nonatomic, strong) UIButton *feed_back;

@end
@implementation signUpViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* set the delegate */
    [_signClassTableList setDataSource:self];
    [_signClassTableList setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:@"signUpCell" bundle:nil];
    
    [self.signClassTableList registerNib:nib forCellReuseIdentifier:@"signUpCell"];
    self.signClassTableList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self prepareSignView];
    
    _s1.delegate = self;
    _s2.delegate = self;
    _s3.delegate = self;
    _s4.delegate = self;
    
    /* set background */
    [self.view setBackgroundColor:[LiziColor backgroundColor]];
    [self.signView setBackgroundColor:[LiziColor backgroundColor]];
    
    /* hide something */
    [self.signIn_completed setHidden:YES];
    [self.signIn_completed setAlpha:1];
    
    /* set table view background */
    [self.signClassTableList setBackgroundColor:[LiziColor backgroundColor]];
    
    /* init the feed_back button */
    self.feed_back = [[UIButton alloc] init];
    
    [self.feed_back setBackgroundImage:[UIImage imageNamed:@"fab"] forState:UIControlStateNormal];
    [self.feed_back setFrame:CGRectMake(0, 0, 30, 30)];
    
    // add it to view.
    [self.view addSubview:self.feed_back];
    
    //move the button.
    [self.feed_back setCenter:CGPointMake(self.view.frame.size.width - 30, self.view.frame.size.height - 30)];
    // hide the button.
    [self.feed_back setAlpha:0.0];
    
    //set target.
    [self.feed_back addTarget:self action:@selector(feedBack:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self prepareData];

}

- (void)feedBack:(UIButton *)sender {
    /*
     * feed back to first row position.
     */
    {
        
        /* scroll to first row */
        [self.signClassTableList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        /* hide the feedBack button */
        [UIView animateWithDuration:1.2 animations:^{
            [self.feed_back setAlpha:0.0];
        } completion:^(BOOL finished) {
            self.off_first_row = NO;
        }];
        
        
        NSLog(@"back to first row");
    }
}

- (void)prepareData {
    
    LiziStudent *stu = [LiziStudent me];
    
    _datas = stu.courses;
    
}

- (void)prepareSignView {
    
    _signViewCenterX = self.view.frame.size.width / 2;
    _signViewCenterHideX = self.view.frame.size.width + _signViewCenterX;
    
    _signView.center = CGPointMake(_signViewCenterHideX, _signView.center.y);
    _signInNow.center = CGPointMake(_signViewCenterHideX, _signView.center.y);
    
    [Tools prepareCustomeView:_classInfo forAttantion:YES];
    [Tools prepareCustomeView:_classNotification forAttantion:YES];
    [Tools prepareCustomeView:_students forAttantion:YES];
    [Tools prepareCustomeView:_classSignIn forAttantion:YES];
    
    [self.view addSubview:_signView];
    [self.view addSubview:_signInNow];
    
    [_signInNow setHidden:YES];
    [_signView setHidden:YES];
    
}

- (void)showClassDetail:(UIView *)v {
    [v setHidden:NO];
    
    [UIView animateWithDuration:0.5 animations:^{
        v.center = CGPointMake(_signViewCenterX, _signView.center.y);
    } completion:^(BOOL finished) {
        //
    }];
    
}

- (void)classBack {
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        _signView.center = CGPointMake(_signViewCenterHideX, _signView.center.y);
    } completion:^(BOOL finished) {
        [_signView setHidden:YES];
    }];
}

- (IBAction)signInComplete:(id)sender {
    
    // end edit
    [self.view endEditing:YES];
    
    /* sign in complete or not */
    // if sign in success show or...
    [self.signIn_completed setHidden:NO];
    
    [UIView animateWithDuration:3.0 animations:^{
        [self.signIn_completed setAlpha:0.0];
        
    } completion:^(BOOL finished) {
        [self.signIn_completed setHidden:YES];
        [self.signIn_completed setAlpha:1.0];
        
        // set navigation
        [self.detailController setNavigationLeftItem:[UIImage imageNamed:@"back"] title:@"课程" withLeftStatus:LeftItemActionBackToSignInList];
        [self.detailController setNavigationRightItem:nil withRightStatus:RightItemActionNone];
        
        //back
        [self signBack];
    }];// warning here ...
    
    //else you shuld get some message from here.
}

- (void)signBack {
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 animations:^{
        _signInNow.center = CGPointMake(_signViewCenterHideX, _signView.center.y);
    } completion:^(BOOL finished) {
        [_signInNow setHidden:YES];
    }];
    
}

- (void)refreshCode
/*
 * refresh the code.
 */
{
    /* end eidt */
    [self.view endEditing:YES];
    
    /* refresh code */
    NSLog(@"refresh code in sign in view controller .");
}
- (IBAction)signIn:(id)sender {
    
    /* set navigation */
    [self.detailController setNavigationLeftItem:[UIImage imageNamed:@"back"] title:@"签到" withLeftStatus:LeftItemActionSignInBack ];
    [self.detailController setNavigationRightItem:[UIImage imageNamed:@"change"] withRightStatus:RightItemActionRefreshCode];
    
    /* */
    
    [self showClassDetail:_signInNow];
    if( [_s1.text isEqualToString:@""]) {

        [_s1 becomeFirstResponder];
    }
    
    
}
- (IBAction)students:(id)sender {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
/*
 * set the feedBack button
 */
{
        
    CGPoint contentOffSetPoint = self.signClassTableList.contentOffset;
    CGFloat heightOfCell = 100;
    
    if( contentOffSetPoint.y >= heightOfCell ){
        if( ! self.off_first_row ) {
            
            // if the row is out off first cell.
            [UIView animateWithDuration:1.2 animations:^{
                [self.feed_back setAlpha:1];
            } completion:^(BOOL finished) {
                self.off_first_row = YES;
            }];
            
        }
        
        NSLog(@"scroll off first row");
    }
    else {
        if( self.off_first_row ) {
            
            [UIView animateWithDuration:1.2 animations:^{
                [self.feed_back setAlpha:0.0];
                
            } completion:^(BOOL finished) {
                self.off_first_row = NO;
            }];
            
        }
    }
}

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [self.detailController setNavigationWithLeftBIcon:[icon backImage] title:@"课程" rightBtIcon:nil withStateCode:rightBarModeClassDetailBack];
    
    /* set navigation property */
    [self.detailController setNavigationLeftItem:[UIImage imageNamed:@"back"] title:@"课程" withLeftStatus:LeftItemActionBackToSignInList];
    [self.detailController setNavigationRightItem:nil withRightStatus:RightItemActionNone];
    
    /* change view */
    [self showClassDetail:_signView];
    [self performSelector:@selector(hideSelectedState:) withObject:nil afterDelay:0.1];
}

- (void)hideSelectedState:(id)sender {
    [self.signClassTableList deselectRowAtIndexPath:[self.signClassTableList indexPathForSelectedRow] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    signUpCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"signUpCell" forIndexPath:indexPath];
    
    /* set table view cell's background */
    [cell setBackgroundColor:[LiziColor backgroundColor]];// cell's background
    [cell.subView setBackgroundColor:[UIColor whiteColor]];// cell's sub view background
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(textField == _s1) {
        if([textField.text length] > 0) {
        [_s1 resignFirstResponder];
            [_s2 setText:string];
        [_s2 becomeFirstResponder];
            
        }
    }
    if(textField == _s2) {
        if([textField.text length] > 0) {
        [_s2 resignFirstResponder];
            [_s3 setText:string];
        [_s3 becomeFirstResponder];
            
        }
    }
    if(textField == _s3) {
        if([textField.text length] > 0) {
        [_s3 resignFirstResponder];
            [_s4 setText:string];
        [_s4 becomeFirstResponder];
            
        }
    }
    if(textField == _s4) {
        if([textField.text length] > 0) {
        [_s4 resignFirstResponder];
            
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if( [textField.text length] == 1) {
       
        textField.text = @"";
    }
    return YES;
}
@end
