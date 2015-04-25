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

- (void)viewDidLoad
/*
 * shen the view did show, and it called.
 */
{
    
    /* prepare for the table view */
    [self.alarmTableList setDelegate:self];
    [self.alarmTableList setDataSource:self];
    [self.alarmTableList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    
}

/* delegate from data source & table view delegate */
/* return the number of table list */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[LiziMyNotifications Noti].myNotifications count];
}

/* return every cell when draw need */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableCell"];
    
    /* data source is LiziMyNotificatios instance */
    LiziMyNotification *my_N = [LiziMyNotifications Noti].myNotifications[[indexPath row]];
    
    cell.textLabel.text = [my_N title];// set the text label.
    
    /* set the notification time */
    NSString *time = [[my_N n_time] descriptionWithLocale:[NSLocale currentLocale]];
    NSString *year = [time componentsSeparatedByString:@" "][3];
    NSString *day = [time componentsSeparatedByString:@" "][2];
    NSString *t = [time componentsSeparatedByString:@" "][5];
    /* format */
    NSString *timeF = [NSString stringWithFormat:@"%@-%@%@", year, day, t];
    
    /* set the detail text */
    cell.detailTextLabel.text = timeF;
    
    /* change the image */
    if( [[my_N n_time] timeIntervalSinceNow] < 0 )
        cell.imageView.image = [UIImage imageNamed:@"signin"];
    else
        cell.imageView.image = [UIImage imageNamed:@"post"];
    
    return cell;//return .
}
/* call it when cell was selected */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* deselected */
    [self performSelector:@selector(hideSelectedState:) withObject:nil afterDelay:0.1];
    
}

- (void)hideSelectedState:(id)sender
/*
 * call it after selected cell.
 */
{
    [self.alarmTableList deselectRowAtIndexPath:[self.alarmTableList indexPathForSelectedRow] animated:YES];
}

/* when edit the cell */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

/* set the cell is edit or not */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    [self.alarmTableList setEditing:editing animated:animated];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if( editingStyle == UITableViewCellEditingStyleDelete) {
        
        /* remove notification */
        [[LiziMyNotifications Noti].myNotifications removeObjectAtIndex:[indexPath row]]
        ;
        
        /* remove notification from local notification */
        NSArray *nos = [[UIApplication sharedApplication] scheduledLocalNotifications];//get the array of notification.
        NSUInteger count = [[[UIApplication sharedApplication] scheduledLocalNotifications] count];//get the notification numbers.
        
        UILocalNotification *no;
        for( int i=0; i < count ; i++) {
            no = nos[i];
            
            if( [no.userInfo[@"index"] isEqualToString:[NSString stringWithFormat:@"%d", [indexPath row]]] ){
                    //remove now.
                [[UIApplication sharedApplication] cancelLocalNotification:no];
                break;
            }
        }
        
        /* remove from table view */
        [self.alarmTableList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.alarmTableList reloadData];
        
        NSLog(@"delete");
    }
}

/* delegate from alarm add */
- (void)updateTableViewData {
    [self.alarmTableList reloadData];
}
- (void)changedData{
    [self.alarmTableList reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.alarmTableList reloadData];
}
@end
