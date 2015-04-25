//
//  LiziHoldingClass.m
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/25.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziHoldingClass.h"
@interface LiziHoldingClass()

@end
@implementation LiziHoldingClass

+ (id)getCurrentClass {
    static LiziHoldingClass *holder;
    if( !holder){
        holder = [[LiziHoldingClass alloc] init];
        holder.current = nil;
    }
    return holder;
}

- (void)setCurrentClass:(id)c_c{
    
    self.current = c_c;
    
}
@end
