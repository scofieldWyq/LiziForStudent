//
//  latestViewController.m
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "latestViewController.h"
#import "latestCell.h"
#import "LiziLatest.h"
#import "LiziColor.h"
#import "LiziClassLatest.h"
#import "LiziLatestDetail.h"

@interface latestViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *latestTableList;
@property (nonatomic, strong) UIButton *feed_back;
@property (nonatomic) BOOL off_first_row;
@end
@implementation latestViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /* add table view to this view */
    [self.view addSubview:_latestTableList];
    [_latestTableList setBackgroundColor:[LiziColor backgroundColor]];
    
    [_latestTableList setDataSource:self];
    [_latestTableList setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:@"latestCell" bundle:nil];
    
    [self.latestTableList registerNib:nib forCellReuseIdentifier:@"latestCell"];
    
    
    /* add feed back button */
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
    
    
    /* load latest */
    [[LiziLatest Latest] latestTemplate];
    
}

- (void)feedBack:(UIButton *)sender
/*
 * feed back to first row position.
 */
{
    
    /* scroll to first row */
    
    [self.latestTableList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    /* hide the feedBack button */
    [UIView animateWithDuration:1.2 animations:^{
        [self.feed_back setAlpha:0.0];
    } completion:^(BOOL finished) {
        self.off_first_row = NO;
    }];
}

/* return the number of cells in table view. */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[LiziLatest Latest].latests count];
}

/* drawing cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    latestCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"latestCell" forIndexPath:indexPath];
    
    LiziClassLatest *oneOfLatest = [[LiziLatest Latest].latests objectAtIndex:[indexPath row]];
    
    cell.className.text = oneOfLatest.c_Name;
    cell.title.text = oneOfLatest.c_title;
    cell.upTime.text = oneOfLatest.c_up_time;
    cell.number.text = oneOfLatest.c_number_talk;
    
    return cell;
}

/* setting the cell's height */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* do something */
    LiziLatestDetail *lld = [[LiziLatestDetail alloc] init];
    [lld.view setFrame:self.view.frame];
    
    [self addChildViewController:lld];
    [self.view addSubview:lld.view];
    [lld didMoveToParentViewController:self];
    [lld showingNowWithData:nil];
    
    /* deselected */
    [self performSelector:@selector(hideSelectedState:) withObject:nil afterDelay:0.1];
}

- (void)hideSelectedState:(id)sender
/*
 * deselected the row .
 */
{
    [self.latestTableList deselectRowAtIndexPath:[self.latestTableList indexPathForSelectedRow] animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
/*
 * set the feedBack button
 */
{

    CGPoint contentOffSetPoint = self.latestTableList.contentOffset;// get the offset of content view.
    CGFloat heightOfCell = 100;// the height of cell.

    if( contentOffSetPoint.y >= heightOfCell ){
        if( ! self.off_first_row ) {
            
            // if the row is out off first cell.
            [UIView animateWithDuration:1.2 animations:^{
                [self.feed_back setAlpha:1];
            } completion:^(BOOL finished) {
                self.off_first_row = YES;
            }];
            
        }
    }
    else {
        if( self.off_first_row ) {
            
            //hide the feedBack button.
            [UIView animateWithDuration:1.2 animations:^{
                [self.feed_back setAlpha:0.0];
                
            } completion:^(BOOL finished) {
                self.off_first_row = NO;
            }];
        }
    }
}

@end
