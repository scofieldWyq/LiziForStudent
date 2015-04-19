//
//  NUPTFirstMainPage.m
//  LiziPage
//
//  Created by 吴英强 on 15/3/16.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "NUPTFirstMainPage.h"
#import "NUPTRegisterPage.h"
#import "NUPTLoginPage.h"
#import "LiziColor.h"
#import "Tools.h"

@implementation NUPTFirstMainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareForViewShow];

    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void) prepareForViewShow{
    
    /* create a status view for set the status color */
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    [statusView setBackgroundColor:[LiziColor statusBarColor]]; //set status color.
    
    [self.view addSubview:statusView]; //add to view.
    
    /* set the button color and font */
    //set color.
    [_login_button setBackgroundColor:[LiziColor buttonColor]];
    [_register_button setBackgroundColor:[LiziColor buttonColor]];
    //set font
    
    
    
}

-(IBAction)login:( UIButton *)sender
/*
 * login action.
 */
{
    
    /* push to next view: login page */
    NUPTLoginPage *logPage = [[NUPTLoginPage alloc] init];
    
    /* custome BarButtonItem */
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc] init];
    backItem.title = [sender currentTitle]; //set title.

    self.navigationItem.backBarButtonItem = backItem;
    
    /* push view , and jump to login page view. */
    [Tools pushView:logPage from:self];
    
}

-(IBAction)registerForMe:( UIButton *)sender
/*
 * register action.
 */
{
    /* push to next view: register page */
    // create class NUPTRegisterPage
    NUPTRegisterPage *registerPage = [[NUPTRegisterPage alloc] init];
    
    /* custome BarButtonItem */
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc] init];
    backItem.title = [sender currentTitle];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    /* push view, and jump to register page */
    [Tools pushView:registerPage from:self];
    
}


/* when the view disappear or not */
-(void)viewWillAppear:(BOOL)animated
/*
 * when the view will appear.
 */
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
/*
 * when the view did disappeared.
 */
{
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}
@end
