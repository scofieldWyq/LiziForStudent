//
//  menuViewController.m
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "menuViewController.h"
#import "UIViewController+mainViewControllerInstance.h"
#import "mainViewController.h"
#import "LiziStudent.h"

@interface menuViewController()
@property (weak, nonatomic) IBOutlet UILabel *myName;
@property (weak, nonatomic) IBOutlet UIImageView *myPhoto;
@property (weak, nonatomic) IBOutlet UIButton *alarming;

@end
@implementation menuViewController
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"menu");
}
- (IBAction)latest:(UIButton *)sender {
//    if([self.detailController removeViewWithCode:NUPTMenuCodeLatest])
//        [self.detailController latestContent];

    [self.detailController changeContentView:MenuStatusLatest];
    
}
- (IBAction)signUp:(UIButton *)sender {
//    if([self.detailController removeViewWithCode:NUPTMenuCodeSign])
//        [self.detailController signInContent];
    [self.detailController changeContentView:MenuStatusSignIn];
    
}
- (IBAction)setting:(UIButton *)sender {
//    if([self.detailController removeViewWithCode:NUPTMenuCodeSetting])
//        [self.detailController settingContent];

    [self.detailController changeContentView:MenuStatusSettings];
}
- (IBAction)alarm:(UIButton *)sender {
//    if([self.detailController removeViewWithCode:NUPTMenuCodeAlarm])
//        [self.detailController alarmContent];
    [self.detailController changeContentView:MenuStatusNotification];
    
}
- (IBAction)aboutMe:(UIButton *)sender {
    /* into my information center */
    [self.detailController changeContentView:MenuStatusPersonCenter];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myPhoto.layer.cornerRadius = _myPhoto.frame.size.width / 2 ;
    _myPhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    _myPhoto.layer.borderWidth = 3.0f;
    _myPhoto.clipsToBounds = YES;
    
    [self setAlarm:NO];
    
}

- (void)updateMenu {
    [self setMyProperty];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setMyProperty];
}

- (void)setMyProperty {
    LiziStudent *me = [LiziStudent me];
    
    [_myName setText:me.name];
    
}

- (void)setAlarm:(BOOL)yesORno {
    if(yesORno){
        [_alarming setHidden:NO];
    }
    else {
        [_alarming setHidden:YES];
    }
}

- (void)prepareForMenu {
    //set photo
    //set name text.
}
@end
