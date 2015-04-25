//
//  LiziAppDelegate.m
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/19.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziAppDelegate.h"
#import "NUPTFirstMainPage.h"
#import "LiziColor.h"
#import "LiziAlarmAdd.h"
#import "LiziHoldingClass.h"
#import "alarmViewController.h"

@implementation LiziAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    /* create first page */
    NUPTFirstMainPage *Mp = [[NUPTFirstMainPage alloc] init];
    //    mainViewController *m = [[mainViewController alloc] init];
    /* create a navigation container and add first page in */
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Mp];
    
    /* set navigation property */
    [self setNavigationProperty:nav];
    
    /* set the nav as root view navigation */
    self.window.rootViewController = nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    LiziAlarmAdd *alarm = [[LiziHoldingClass getCurrentClass] current];
    [alarm.del changedData];
    
    NSLog(@"notification deal");
}

- (void)setNavigationProperty:(UINavigationController *)nvc{
    
    /* in first page, hide the navigation bar.
     */
    //    [nvc.navigationBar setHidden:YES];
    
    
    /* set some property for status bar
     */
    
    UIView *statusBarGround = [[UIView alloc] init];
    [statusBarGround setFrame:CGRectMake(0, -20, CGRectGetWidth(self.window.frame), 20)];
    [statusBarGround setBackgroundColor:[LiziColor statusBarColor]];//set status bar color
    [nvc.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];//set navigationBar color.
    [nvc.navigationBar addSubview:statusBarGround];
    [nvc.navigationBar setTintColor:[UIColor whiteColor]]; //set navigation bar title color.
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
