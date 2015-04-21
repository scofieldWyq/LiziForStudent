//
//  LiziClass.m
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/21.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziClass.h"

@implementation LiziClass

- (instancetype)initWithName:(NSString *)name Info:(NSString *)info Teacher:(NSString *)teacher ID:(NSString *)class_id {
    
    self = [super init];
    
    if(self){
        
        self.c_name = name;
        self.c_info = info;
        self.c_teacher = teacher;
        self.c_id = class_id;
        
    }
    
    return self;
}
@end
