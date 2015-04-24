//
//  alarmViewController.m
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "alarmViewController.h"
#import "LiziMyNotifications.h"
#import "LiziMyNotification.h"
#import "LiziAlarmAdd.h"

@interface alarmViewController()<UITableViewDataSource, UITableViewDelegate, updateView>

@property (weak, nonatomic) IBOutlet UITableView *alarmTableList;
@end
@implementation alarmViewController

- (void)viewDidLoad{
    
    /* prepare for the table view */
    [self.alarmTableList setDelegate:self];
    [self.alarmTableList setDataSource:self];
    [self.alarmTableList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"alarm");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[LiziMyNotifications Noti].myNotifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableCell"];
    
    LiziMyNotification *my_N = [LiziMyNotifications Noti].myNotifications[[indexPath row]];
    
    cell.textLabel.text = [my_N title];
    
    /* set the notification time */
    NSString *time = [[my_N n_time] descriptionWithLocale:[NSLocale currentLocale]];
    NSString *year = [time componentsSeparatedByString:@" "][3];
    NSString *day = [time componentsSeparatedByString:@" "][2];
    NSString *t = [time componentsSeparatedByString:@" "][5];
    
    NSString *timeF = [NSString stringWithFormat:@"%@-%@%@", year, day, t];
    cell.detailTextLabel.text = timeF;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    /* deselected */
    [self performSelector:@selector(hideSelectedState:) withObject:nil afterDelay:0.1];
    
}

- (void)hideSelectedState:(id)sender {
    [self.alarmTableList deselectRowAtIndexPath:[self.alarmTableList indexPathForSelectedRow] animated:YES];
}

- (void)updateTableViewData {
    [self.alarmTableList reloadData];
}
@end
