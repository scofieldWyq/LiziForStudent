//
//  LiziClassLatest.h
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/23.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiziClassLatest : NSObject

@property (nonatomic, strong) NSString *c_Name;
@property (nonatomic, strong) NSString *c_title;
@property (nonatomic, strong) NSString *c_up_time;
@property (nonatomic, strong) NSString *c_number_talk;

- (void)setClassWithName:(NSString *)name title:(NSString *)title time:(NSString *)time number:(NSString *)number;
@end
