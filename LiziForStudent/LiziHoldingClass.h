//
//  LiziHoldingClass.h
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/25.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiziHoldingClass : NSObject
@property (nonatomic, strong) id current;
+ (id)getCurrentClass;
- (void)setCurrentClass:(id)c_c;
@end
