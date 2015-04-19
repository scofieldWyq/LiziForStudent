//
//  LiziCheckStatusCode.h
//  LiziForTeacher
//
//  Created by 吴英强 on 15/4/14.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DataStatus){
    DataStatusSuccess = 0,
    DataStatusError = 1,
    DataStatusRegisterAlready = 2,
    DataStatusInfoNotComplete = 3,
    DataStatusTokenIdentifyTimeOut = 4,
    DataStatusTypeError = 5,
    DataStatusTokenChanged = 6,
    DataStatusTokenError = 7,
    DataStatusTokenIsNotrefreshToken = 8
};

@interface LiziCheckStatusCode : NSObject
+ (BOOL)checking:(NSString *)st;
@end
