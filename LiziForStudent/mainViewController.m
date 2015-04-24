//
//  mainViewController.m
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "mainViewController.h"
#import "menuViewController.h"
#import "latestViewController.h"
#import "signUpViewController.h"
#import "settingViewController.h"
#import "alarmViewController.h"
#import "myInfoViewController.h"
#import "LiziStudent.h"
#import "LiziColor.h"
#import "LiziAlarmAdd.h"

@interface mainViewController () <UIGestureRecognizerDelegate>
//navigate bar property
@property (weak, nonatomic) IBOutlet UIButton *navigationLeftButton;
@property (weak, nonatomic) IBOutlet UILabel *navigationLeftLabel;
@property (weak, nonatomic) IBOutlet UIButton *navigationRightButton;

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) menuViewController *menuVController;
@property (nonatomic, strong) UIViewController *currentContentVController;


//other properties.
@property (nonatomic) CGRect contentWindow;
//@property (nonatomic) CGRect menuWindow;
@property (nonatomic) float menuCenterX;
@property (nonatomic) float contentCenterX;
@property (nonatomic) float presentViewCenterX;
//@property (nonatomic) float centerHeight;
@property (nonatomic) float menuPresentCenterX;
@property (nonatomic) float windowHeight;

@property (nonatomic) rightBarMode rightMode;
@property (nonatomic, strong) UIButton *menuButton;


/* about menu status */
//@property (nonatomic) MenuStatus menuStatusNow;
@property (nonatomic) MenuStatus menuStatusOld;
/* about left item action status */
@property (nonatomic) LeftItemAction leftActionNow;
/* about right item action status */
@property (nonatomic) RightItemAction rightActionNow;

/* about menu coordinate */
//hide
@property (nonatomic) CGFloat menuHideCenterX;
@property (nonatomic) CGFloat menuHideCenterY;
//show
@property (nonatomic) CGFloat menuShowCenterX;
@property (nonatomic) CGFloat menuShowCenterY;


/* about content coordinate */
@property (nonatomic) CGFloat contentWillShowPositionX;
@property (nonatomic) CGFloat contentWillShowPositionY;

/* current content coordinate */
@property (nonatomic) CGFloat contentCurrentX;
@property (nonatomic) CGFloat contentCurrentY;

@end
@implementation mainViewController

- (IBAction)rightBarWithNavigate:(id)sender {
    
    switch (self.rightActionNow) {
        case RightItemActionNone:
        break;
            
        case RightItemActionClassAdd:{
            // class add.
            NSLog(@"class add");
        }
        break;
            
        case RightItemActionEditMyInformation: {
            /* edit mode, image <eidt> */
            /* into edit mode */
            [ (myInfoViewController *) _currentContentVController editMode];
            
            /* change the navigation of title and state */
            [self setNavigationLeftItem:[UIImage imageNamed:@"back"] title:@"资料编辑" withLeftStatus:LeftItemActionPersonCenter];
            [self setNavigationRightItem:[UIImage imageNamed:@"done"] withRightStatus:RightItemActionEditMyInformationDone];
        }
        break;
            
        case RightItemActionCreateClassDone: {
            
        }
        break;
            
        case RightItemActionEditClassDone: {
            
        }
        break;
            
        case RightItemActionEditMyInformationDone: {
            
            /* cancel edit mode */
            [ (myInfoViewController *) _currentContentVController setProperty];
            [ (myInfoViewController *) _currentContentVController noEditMode];
            
            /* back to person center */
            [self setNavigationLeftItem:[UIImage imageNamed:@"back"] title:@"个人中心" withLeftStatus:LeftItemActionBackToMain];
            [self setNavigationRightItem:[UIImage imageNamed:@"edit"] withRightStatus:RightItemActionEditMyInformation];
        }
        break;
            
        case RightItemActionRefreshClassmate: {
            
        }
        case RightItemActionRefreshCode: {
            
            /* refresh code */
            [(signUpViewController *) _currentContentVController refreshCode];
        }
        break;
            
        case RightItemActionSendMyIdea: {
            
            /* send */
            [ (settingViewController *) _currentContentVController sendMyIdea];
            
            NSLog(@"send data from my idea view");
        }
        break;
            
        case RightItemActionNotificationAdd: {
            /* add notification */
            LiziAlarmAdd *alarmAdd = [[LiziAlarmAdd alloc] init];
            [alarmAdd.view setFrame:self.view.frame];
            
            /* add to parent */
            [self addChildViewController:alarmAdd];
            [self.view addSubview:alarmAdd.view];
            [alarmAdd didMoveToParentViewController:self];
            [alarmAdd.view setAlpha:0];
            
            /* animation */
            [UIView animateWithDuration:0.5 animations:^{
                [alarmAdd.view setAlpha:1];
            } completion:^(BOOL finished) {
                [alarmAdd setDataDelegate:(alarmViewController *) _currentContentVController];
            }];
            
            NSLog(@"add alarm");
        }
            
        default:
            break;
    }
}

- (IBAction)leftBarWithNavigate:(id)sender {
    
    switch (self.leftActionNow) {
        case LeftItemActionNone: {
            [self showMenu];
        }
            break;
        case LeftItemActionBackToForwardView: {
            
        }
            break;
        case LeftItemActionEditMyInformation: {
            
        }
            break;
        case LeftItemActionPersonCenter: {
            
            //back to person center from edit mode.
            /* cancel edit mode */
            [ (myInfoViewController *) _currentContentVController noEditMode];
            
            /* back to person center */
            [self setNavigationLeftItem:[UIImage imageNamed:@"back"] title:@"个人中心" withLeftStatus:LeftItemActionBackToMain];
            [self setNavigationRightItem:[UIImage imageNamed:@"edit"] withRightStatus:RightItemActionEditMyInformation];
            
        }
            break;
        case LeftItemActionShowMenu: {
            
        }
        case LeftItemActionBackToMain: {
            
            [self changeContentView:MenuStatusLatest];
            self.leftActionNow = LeftItemActionNone;
        }
        break;
        case LeftItemActionBackToSignInList: {
            
            /* show the next view */
            [ (signUpViewController *)_currentContentVController classBack];
            
            /* change navigation title and icon */
            [self setNavigationLeftItem:[UIImage imageNamed:@"menu"] title:@"课程" withLeftStatus:LeftItemActionNone];
            [self setNavigationRightItem:[UIImage imageNamed:@"creat(add)"] withRightStatus:RightItemActionClassAdd];
            
        }
        break;
        case LeftItemActionSignInBack: {
            
            /* back to class detial */
            [ (signUpViewController *) _currentContentVController signBack];
            
            /* change navigation title */
            [self setNavigationLeftItem:[UIImage imageNamed:@"back"] title:@"课程" withLeftStatus:LeftItemActionBackToSignInList];
            [self setNavigationRightItem:nil withRightStatus:RightItemActionNone];
        }
        break;
            
        case LeftItemActionIdeaViewBack: {
            
            /* back to setting view */
            [self setNavigationLeftItem:[UIImage imageNamed:@"menu"] title:@"设置" withLeftStatus:LeftItemActionNone];
            [self setNavigationRightItem:nil withRightStatus:RightItemActionNone];
            
            /* back to */
            [ (settingViewController *)_currentContentVController back];
        }
            
        default:
            break;
    }
}

- (void)prepareForSomeData {
    
    // set hiden menu center x.
    self.menuHideCenterX = - (self.view.frame.size.width / 2);
    self.menuHideCenterY = self.view.frame.size.height / 2;
    
    // set content will show position.
    self.contentWillShowPositionX = (self.view.frame.size.width * 1.5);
    self.contentWillShowPositionY = (self.view.frame.size.height - 65 ) / 2  + 65;
    
    // set content did show position.
    self.contentCurrentX = self.view.frame.size.width / 2;
    self.contentCurrentY = (self.view.frame.size.height - 65 ) / 2  + 65;
    
    /* menu status */
//    self.menuStatusNow = MenuStatusLatest;
    self.menuStatusOld = MenuStatusLatest;
    /* left status */
    self.leftActionNow = LeftItemActionNone;
    /* right status */
    self.rightActionNow = RightItemActionNone;
    
    
    
    
    _contentWindow = CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height - 65) ;
    
    _menuCenterX = - (self.view.frame.size.width / 2 );
    
    _contentCenterX = (self.view.frame.size.width * 1.5);
    
    _presentViewCenterX = (self.view.frame.size.width / 2);
    _windowHeight = (self.view.frame.size.height / 2);
//    _centerHeight = (self.view.frame.size.height - 65 ) / 2  + 65;
    _menuPresentCenterX = ( _presentViewCenterX );
    
    _rightMode = rightBarModeNULL;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /* hide the navigationBar */
    [self.navigationController.navigationBar setHidden:YES];
    
    /* set the status bar color */
    [self.statusBarP setBackgroundColor:[LiziColor statusBarColor]];
    
    /* prepare for data */
    [self prepareForSomeData];
    [_navigationRightButton setHidden:YES];
    
    [self prepareMenuView];
    [self prepareContentView];
    
    [self.view addSubview:_contentView];
    [self.view addSubview:_menuView];
    
//     [self setNavigationWithMenuState:_menuCode];
    
    /* setting the gesture recognizer */
//    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
//    panGestureRecognizer.delegate = self;
//    panGestureRecognizer.maximumNumberOfTouches = 1;
//    [self.view addGestureRecognizer:panGestureRecognizer];
    
}

- (void)setNavigationLeftItem:(UIImage *)item title:(NSString *)title withLeftStatus:(LeftItemAction)leftAction
/*
 * set the left item image and title.
 */
{
    [_navigationLeftButton setBackgroundImage:item forState:UIControlStateNormal];
    [_navigationLeftLabel setText:title];
    self.leftActionNow = leftAction;
    
}

- (void)setNavigationRightItem:(UIImage *)item withRightStatus:(RightItemAction)rightAction
/*
 * set the right image.
 */
{
    if(item){
        
        [self.navigationRightButton setBackgroundImage:item forState:UIControlStateNormal];
        [self.navigationRightButton setHidden:NO];
        [self.navigationRightButton setEnabled:YES];
        self.rightActionNow = rightAction;
        
    }
    else {
        [self.navigationRightButton setEnabled:NO];
        [self.navigationRightButton setHidden:YES];
    }
}

- (void)setLeftButtonAction:(LeftItemAction)leftStatus{
}
- (void)setRightButtonAction:(RightItemAction)rightStatus{
    
}

- (void)changeContentView:(MenuStatus) menuState {
    

    /* if you in this view before, you did not need to do it.*/
    if( menuState == self.menuStatusOld ) {
        // just hide menu.
        [self hideMenu];
         return ;
    }
    
    switch (menuState) {
        case MenuStatusLatest: {

            /* change the navigation bar */
            [self setNavigationLeftItem:[UIImage imageNamed:@"menu"] title:@"主页" withLeftStatus:LeftItemActionNone];
            [self setNavigationRightItem:nil withRightStatus:RightItemActionNone];
            
            /* hide menu */
            [self hideMenu];
            
            /* hide current view and remove it */
            [self hideContent];
            
            /* show latest view page */
            [self latestContent];
            
        }
            break;
        case MenuStatusSignIn: {
 
            /* change the navigation bar */
            [self setNavigationLeftItem:[UIImage imageNamed:@"menu"] title:@"课程" withLeftStatus:LeftItemActionNone] ;
            [self setNavigationRightItem:[UIImage imageNamed:@"creat(add)"] withRightStatus:RightItemActionClassAdd];
            
            /* hide menu */
            [self hideMenu];
            
            /* hide current view and remove it */
            [self hideContent];
            
            /* show signIn view page */
            [self signInContent];
            
        }
            break;
        case MenuStatusSettings: {
 
            /* change the navigation bar */
            [self setNavigationLeftItem:[UIImage imageNamed:@"menu"] title:@"设置" withLeftStatus:LeftItemActionNone];
            [self setNavigationRightItem:nil withRightStatus:RightItemActionNone];
            
            /* hide menu */
            [self hideMenu];
            
            /* hide current view and remove it */
            [self hideContent];
            
            /* show setting view page */
            [self settingContent];
            
        }
            break;
        case MenuStatusNotification: {

            /* change the navigation bar */
            [self setNavigationLeftItem:[UIImage imageNamed:@"menu"] title:@"提醒" withLeftStatus:LeftItemActionNone];
            [self setNavigationRightItem:[UIImage imageNamed:@"creat(add)"] withRightStatus:RightItemActionNotificationAdd];
            
            /* hide menu */
            [self hideMenu];
            
            /* hide current view and remove it */
            [self hideContent];
            
            /* show alarm view page */
            [self alarmContent];
            
        }
            break;
        case MenuStatusPersonCenter: {
 
            /* change the navigation bar */
            [self setNavigationLeftItem:[UIImage imageNamed:@"back"] title:@"个人中心" withLeftStatus:LeftItemActionBackToMain];
            [self setNavigationRightItem:[UIImage imageNamed:@"edit"] withRightStatus:RightItemActionEditMyInformation];
            
            /* hide menu */
            [self hideMenu];
            
            /* hide current view and remove it */
            [self hideContent];
            
            /* show person center view page */
            [self myInformation];
            
        }
            break;
            
        default:
            break;
    }
    
    self.menuStatusOld = menuState;
}

//- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)sender {
//    
//    CGPoint point = [sender locationInView:self.view];
//    
//    switch (sender.state){
//        case UIGestureRecognizerStateBegan: {
//            NSLog(@"state began");
//        }
//            break;
//        case UIGestureRecognizerStateChanged: {
//            NSLog(@"state changed");
//        }
//            break;
//        case UIGestureRecognizerStateEnded: {
//            NSLog(@"state end");
//        }
//            break;
//        case UIGestureRecognizerStateCancelled: {
//            
//        }
//            break;
//        case UIGestureRecognizerStatePossible: {
//            
//        }
//            break;
//        case UIGestureRecognizerStateFailed: {
//            
//        }
//            break;
//        default:
//            break;
//    }
//}


- (void)hidingMenu:(UIButton *)sender {
    [self hideMenu];
}


- (void)prepareMenuView
/*
 * load menu view and some properties.
 */
{
    
    self.menuView = [[UIView alloc] initWithFrame:self.view.bounds];    //create a menu view.
    [self.menuView setBackgroundColor:[UIColor clearColor]];            // set the view background.
    
    self.menuButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectNull;
        [button addTarget:self action:@selector(hidingMenu:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _menuView.center = CGPointMake(self.menuHideCenterX, self.menuHideCenterY);//center of menu that is hiding.
    
    /* menu view controller */
    menuViewController *menuVC = [[menuViewController alloc] init];
    self.menuVController = menuVC;// set the menu view controller.
    
    /* add menu view controller as a child of main view controller */
    [self addChildViewController:menuVC];
    
    [_menuView addSubview:menuVC.view];
    
    [menuVC didMoveToParentViewController:self];
    
    
    /* insert button into the menu. */
    if(! self.menuButton.superview){
        self.menuButton.frame = self.menuView.bounds;
        [self .menuView insertSubview:self.menuButton atIndex:0];
        
    }
    
    [_menuView setHidden:YES];
    
    /* set the first view */
//    self.menuStatusNow = MenuStatusLatest;
    self.menuStatusOld = MenuStatusLatest;
    /* ... */
//    _menuCode = NUPTMenuCodeLatest;
}

- (void)prepareContentView {
    
    
    _contentView = [[UIView alloc] initWithFrame: _contentWindow];// create a content view.
    
    [_contentView setBackgroundColor: [UIColor whiteColor]];// content background.
    _contentView.center = CGPointMake( self.contentWillShowPositionX, self.contentWillShowPositionY); // set the center coodinate.
    
    [self setNavigationLeftItem:[UIImage imageNamed:@"menu"] title:@"主页" withLeftStatus:LeftItemActionNone];
    [self setNavigationRightItem:nil withRightStatus:RightItemActionNone];
    [self latestContent];
    
}

- (void)showMenu {
    [_menuView setHidden:NO];
    
    [UIView animateWithDuration:0.5 animations:^{
        _menuView.center = CGPointMake(_menuPresentCenterX, _windowHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.75 animations:^{
            [_menuButton setBackgroundColor:[UIColor lightGrayColor]];
            _menuButton.alpha = 0.5;
        }];
        
        [_menuVController updateMenu];
    }];
}

- (void)hideMenu {
    [UIView animateWithDuration:0.75 animations:^{
        [_menuButton setBackgroundColor:[UIColor clearColor]];
        _menuButton.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _menuView.center = CGPointMake(_menuCenterX, _windowHeight);
        } completion:^(BOOL finished) {
            [self.menuView setHidden:YES];
        }];
    }];
   
}

- (void)showContent
/*
 * show the content view.
 */
{
    /* set the content view is showing */
    [_contentView setHidden:NO];
    
    /* move the view into content area */
    [UIView animateWithDuration:0.5 animations:^{
        _contentView.center = CGPointMake(self.contentCurrentX, self.contentCurrentY);
    }];
    
}

- (void)hideContent
/*
 * hide the current content view.
 */
{
    /* move the current view out of main window */
    [UIView animateWithDuration:0.5 animations:^{
        _contentView.center = CGPointMake(self.contentWillShowPositionX, self.contentWillShowPositionY);
    }];
    
    /* moved done, hide it */
    [_contentView setHidden:YES];
    
    /* kill the view page */
    if(_currentContentVController) {
        
        if(! [self.contentView isHidden])
            [self hideContent];
        
        [_currentContentVController.view removeFromSuperview];
        [_currentContentVController removeFromParentViewController];
        
        _currentContentVController = nil;
    }
    
}

- (void)latestContent {
    
    // create a latest view controller.
    latestViewController *latestVC = [[latestViewController alloc] init];
    
    /* add it to current view controller */
    [self addChildViewController:latestVC];
    
    _currentContentVController = latestVC;
    latestVC.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    /* add it into current view page */
    [_contentView addSubview:latestVC.view];
    
    /* show content */
    [self showContent];
}

- (void)signInContent {
    
    /* create a singIn view */
    signUpViewController *signVC = [[signUpViewController alloc] init];
    
    /* add it to current view controller */
    [self addChildViewController:signVC];
    
    _currentContentVController = signVC;
    
    /* add it into current view page */
    [_contentView addSubview:signVC.view];
    
    
    /* show content */
    [self showContent];
}


- (void)settingContent {

    /* create setting view controller */
    settingViewController *settingVC = [[settingViewController alloc] init];
    
    /* add it to current view controller */
    [self addChildViewController:settingVC];
    
    _currentContentVController = settingVC;
    
    /* add it into current view page */
    [_contentView addSubview:settingVC.view];
    
    /* show content */
    [self showContent];
    
}

- (void)alarmContent {
    
    /* create alarm view controller */
    alarmViewController *alarmVC = [[alarmViewController alloc] init];
    
    /* add it to current view controller */
    [self addChildViewController:alarmVC];
    
    _currentContentVController = alarmVC;
    
    /* add it into current view page */
    [_contentView addSubview:alarmVC.view];
    
     /* show content */
    [self showContent];
}

- (void)myInformation {

    /* create person information view controller */
    myInfoViewController *myInfoVC = [[myInfoViewController alloc] init];
    
    /* add it to current view controller */
    [self addChildViewController:myInfoVC];
    
    _currentContentVController = myInfoVC;
    
    /* add it into current view page */
    [_contentView addSubview:myInfoVC.view];
    
    /* show content */
    [self showContent];
    
}
- (void)setNavigationWithMenuState:(NUPTMenuCode)status {
    
    if( status == NUPTMenuCodePersonInfo){
        
        [_navigationLeftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }else {
            [_navigationLeftButton setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    }
    
    switch (status) {
        case NUPTMenuCodeLatest: {
            [_navigationLeftLabel setText:@"动态"];
            if( ! [self.navigationRightButton isHidden]){
            
                [self hideRightBar:YES];
            }
        }
            break;
        case NUPTMenuCodeSign: {
            if([self.navigationRightButton isHidden]) {
                [self setRightBarWithImage:[UIImage imageNamed:@"creat(add)"]];
            }
            [_navigationLeftLabel setText:@"课程"];
            
        }
            break;
        case NUPTMenuCodeSetting: {
            if( ! [self.navigationRightButton isHidden]){
                
                [self hideRightBar:YES];
            }

            [_navigationLeftLabel setText:@"设置"];
            
        }
            break;
        case NUPTMenuCodeAlarm: {
            if( ! [self.navigationRightButton isHidden]){
                
                [self hideRightBar:YES];
            }

            [_navigationLeftLabel setText:@"提醒"];
            
        }
            break;
        case NUPTMenuCodePersonInfo: {

            [self setNavigationWithLeftBIcon:[UIImage imageNamed:@"back"] title:@"个人中心" rightBtIcon:[UIImage imageNamed:@"edit"] withStateCode:rightBarModeEditMyInformation];
        }
            break;
        default:
            break;
    }
}


/* will delete it !*/
- (void)setNavigationWithLeftBIcon:(UIImage *)icon1 title:(NSString *)text  rightBtIcon:(UIImage *)icon2 {
    
    [_navigationLeftButton setBackgroundImage:icon1 forState:UIControlStateNormal];
    [_navigationLeftLabel setText:text];
    
    if(icon2){
    
        [_navigationRightButton setBackgroundImage:icon2 forState:UIControlStateNormal];
        [self hideRightBar:NO];
    }
    else {
        [self hideRightBar:YES];
    }
}

- (void)hideRightBar:(BOOL)yes {
    if(yes) {
        [_navigationRightButton setEnabled:NO];
        [_navigationRightButton setHidden:YES];
    }
    else {
        [_navigationRightButton setEnabled:YES];
        [_navigationRightButton setHidden:NO];
    }
}

- (void)setRightBarWithImage:(UIImage *)img {
    if( !img ) {
        [self hideRightBar:YES];
        return ;
    }
    else {
        [self hideRightBar:NO];
        [_navigationRightButton setBackgroundImage:img forState:UIControlStateNormal];
    }
}

- (void)setNavigationWithLeftBIcon:(UIImage *)icon1 title:(NSString *)text  rightBtIcon:(UIImage *)icon2 withStateCode:(rightBarMode)mode {
    [self setNavigationWithLeftBIcon:icon1 title:text rightBtIcon:icon2];
    
    _rightMode = mode;
}

@end
