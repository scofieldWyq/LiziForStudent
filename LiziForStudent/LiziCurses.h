//
//  LiziCurses.h
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/21.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiziCurses : NSObject
@property (nonatomic, strong) NSMutableArray *curses;
+ (LiziCurses *)getCurses;

- (void)templation;
@end
