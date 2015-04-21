//
//  LiziStudent.h
//  LiziFirstReleased
//
//  Created by 吴英强 on 15/3/31.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface LiziStudent : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *messageCode;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSMutableArray *courses;
@property (nonatomic, strong) NSString *sex;

+ (LiziStudent *)me;
- (void)loadStudentData:(NSData *)data;

- (void)templation;
@end
