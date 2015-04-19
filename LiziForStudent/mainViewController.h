//
//  mainViewController.h
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, NUPTMenuCode){
    NUPTMenuCodeDefaultState = 0,
    NUPTMenuCodeSign = 1,
    NUPTMenuCodeSetting = 2,
    NUPTMenuCodeAlarm = 3,
    NUPTMenuCodePersonInfo = 4,
    NUPTMenuCodeLatest = 5
};
typedef  NS_ENUM(NSInteger, rightBarMode) {
    rightBarModeForAddClass = 0,
    rightBarModeEditMyInformation = 1,
    rightBarModeOk = 2,
    rightBarModeUPdate = 3,
    rightBarModeSendMyIdea = 4,
    rightBarModeNULL = 5,
    rightBarModeClassDetailBack = 6,
    rightBarModeClassAdd = 7,
    rightBarModeSignIn = 8,
    rightBarModeSignInNow = 9
};



/* menu status 
 * to let the main view page know about what modul to show
 */
typedef NS_ENUM(NSInteger, MenuStatus) {
    
    MenuStatusLatest = 0,
    MenuStatusSignIn = 1,
    MenuStatusNotification = 2,
    MenuStatusSettings = 3,
    MenuStatusPersonCenter = 4
    
};

/*
 * left button action state.
 */
typedef NS_ENUM(NSInteger, LeftItemAction){
    
    LeftItemActionPersonCenter = 0,
    LeftItemActionEditMyInformation = 1,
    LeftItemActionBackToForwardView = 2,
    LeftItemActionBackToMain = 3,
    LeftItemActionShowMenu = 4,
    LeftItemActionNone = 5,
    LeftItemActionBackToSignInList = 6,
    LeftItemActionSignInBack = 7,
    LeftItemActionIdeaViewBack = 8
    
};

/*
 * right button action state.
 */
typedef NS_ENUM(NSInteger, RightItemAction){
 
    RightItemActionEditMyInformation = 0,
    RightItemActionEditMyInformationDone = 1,
    RightItemActionClassAdd = 2,
    RightItemActionCreateClassDone = 3,
    RightItemActionEditClassDone = 4,
    RightItemActionSendMyIdea = 5,
    RightItemActionRefreshCode = 6,
    RightItemActionRefreshClassmate = 7,
    RightItemActionNone = 8
    
};



@interface mainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *statusBarP;
@property (weak, nonatomic) IBOutlet UIImageView *navigationImage;

- (void)changeContentView:(MenuStatus) menuState;
- (void)latestContent;
- (void)signInContent;
- (void)settingContent;
- (void)alarmContent;
- (void)myInformation;
- (void)setNavigationWithLeftBIcon:(UIImage *)icon1 title:(NSString *)text  rightBtIcon:(UIImage *)icon2 withStateCode:(rightBarMode)mode;

- (void)setNavigationLeftItem:(UIImage *)item title:(NSString *)title withLeftStatus:(LeftItemAction)leftAction;
- (void)setNavigationRightItem:(UIImage *)item withRightStatus:(RightItemAction)rightAction;

@end
