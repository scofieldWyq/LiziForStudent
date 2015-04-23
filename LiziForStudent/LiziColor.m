//
//  LiziColor.m
//  LiziForTeacher
//
//  Created by 吴英强 on 15/4/13.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziColor.h"

@implementation LiziColor
+ (UIColor *)statusBarColor {
    return [self initWithRed:0xff green:0xbb blue:0x00];
}

+ (UIColor *)backgroundColor {
    return [self initWithRed:0xf7 green:0xf8 blue:0xf8];
}

+(UIColor *)buttonColor {
    return [self initWithRed:0xff green:0xcc blue:0x3f];
}

+ (UIColor *)navigationColor {
    return [self initWithRed:0xff green:0xcd blue:0x40];
}

+ (UIColor *)initWithRed:(double)r green:(double)g blue:(double)b {
    UIColor *color;
    color = [[UIColor alloc] initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
    return color;
}
@end
