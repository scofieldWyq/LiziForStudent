//
//  LiziClass.h
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/21.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiziClass : NSObject
@property (nonatomic, strong) NSString *c_name;
@property (nonatomic, strong) NSString *c_info;
@property (nonatomic, strong) NSString *c_teacher;
@property (nonatomic, strong) NSString *c_id;

- (instancetype)initWithName:(NSString *)name Info:(NSString *)info Teacher:(NSString *)teacher ID:(NSString *)class_id;

@end
