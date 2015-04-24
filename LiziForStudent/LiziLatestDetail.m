//
//  LiziLatestDetail.m
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/24.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziLatestDetail.h"

@implementation LiziLatestDetail
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *bt = [[UIButton alloc] initWithFrame:self.view.frame];
    [bt setBackgroundColor:[UIColor lightGrayColor]];
    [bt setAlpha:0.5];
    [bt addTarget:self action:@selector(hidingNow:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bt];
    
    self.tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 260, 400) style:UITableViewStylePlain];
    self.tv.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    self.tv.delegate = self;
    self.tv.dataSource = self;
    [self.tv setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.tv];// add view
    [self.view setAlpha:0];
    
}

- (void)hidingNow:(UIButton *)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setAlpha:0];
        
    } completion:^(BOOL finished) {
        //
    }];
    
    NSLog(@"hiding");
}

- (void)showingNowWithData:(NSArray *)titles{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setAlpha:1];
        
    } completion:^(BOOL finished) {
        //
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
