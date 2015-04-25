//
//  LiziAlarmAdd.m
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/24.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziAlarmAdd.h"
#import "LiziNotificationDetail.h"
#import "LiziMyNotifications.h"
#import "LiziMyNotification.h"
#import "LiziHoldingClass.h"

@implementation LiziAlarmAdd

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /* preparation */
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setAlpha:0.5];
    [btn addTarget:self action:@selector(hidingNow:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    /* navigation */
    UINavigationController *nvc = [[UINavigationController alloc] init];
    [nvc.view setFrame:CGRectMake(0, 0, 320, 420)];
    nvc.view.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    LiziNotificationDetail *vc = [[LiziNotificationDetail alloc] init];
    
    [vc.view setBackgroundColor:[UIColor whiteColor]];
  
    /* set left & right item */
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAdd:)];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addItem:)];
    
    vc.navigationItem.leftBarButtonItem = cancelItem;
    vc.navigationItem.rightBarButtonItem = addItem;
    vc.navigationItem.title = @"alarm";
    [nvc pushViewController:vc animated:YES];
    
    [self addChildViewController:nvc];
    [self.view addSubview:nvc.view];
    [nvc didMoveToParentViewController:self];
    self.notificationDetailAdd = vc;
    
}


- (void)cancelAdd:(UIButton *)sender
/*
 * just hide.
 */
{
    [self hidingNow:nil];
}

- (void)setDataDelegate:(id)dele {
    self.del = dele;
}

- (void)addItem:(UIButton *)sender
/*
 * add the notification to local.
 */
{
    
    /* create a notification */
    LiziMyNotification *n = [[LiziMyNotification alloc] init];
    int number;
    
    /* check the text is complete or not */
    if( [self.notificationDetailAdd.notifications.text isEqualToString:@""] || [self.notificationDetailAdd.myTitle.text isEqualToString:@""]){
        
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"信息不完整" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil] show];
        return ;
    }
    
    /* set some property  */
    n.title = self.notificationDetailAdd.myTitle.text;
    n.content = self.notificationDetailAdd.notifications.text;
    n.n_time = self.notificationDetailAdd.N_time.date;
    
    /* add notification to notifications */
    number = [[LiziMyNotifications Noti].myNotifications count];//get the index;
    [[LiziMyNotifications Noti].myNotifications addObject:n];
    
    /* add to notification */
    UILocalNotification *no = [[UILocalNotification alloc] init];
    no.alertAction = n.title;
    no.fireDate = n.n_time;
    no.alertBody = n.title;
    
    /* set the tag for deleting */
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", number] forKey:@"index"];
    
    no.userInfo = userInfo;

    /* save class */
    [[LiziHoldingClass getCurrentClass] setCurrentClass:self];
    
    
    [[UIApplication sharedApplication] scheduleLocalNotification:no];
    
    /* update the table view */
    [self.del updateTableViewData];
    
    /* distroy */
    [self hidingNow:nil];
    
}

- (void)hidingNow:(UIButton *)sender{
    /*hide the view and remove it out of parent view */
    
    
    /* hide view */
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setAlpha:0];
        
    } completion:^(BOOL finished) {
        //move out of parent view
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        self.notificationDetailAdd = nil;
        
    }];
}
@end
