//
//  LiziCheckStatusCode.m
//  LiziForTeacher
//
//  Created by 吴英强 on 15/4/14.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziCheckStatusCode.h"

@implementation LiziCheckStatusCode

+ (BOOL)checking:(NSString *)st {
    switch ([self check:st]) {
        case DataStatusSuccess:{
            return YES;
        }
            break;
        case DataStatusError: {
            //reason
        }
            break;
        case DataStatusInfoNotComplete: {
            //reason
        }
            break;
        case DataStatusRegisterAlready: {
            //reason
        }
            break;
        case DataStatusTokenChanged: {
            //reason
        }
            break;
        case DataStatusTokenError: {
            //reason
        }
            break;
        case DataStatusTokenIdentifyTimeOut: {
           //reason
        }
            break;
        case DataStatusTokenIsNotrefreshToken: {
            //reason
        }
        case DataStatusTypeError: {
            //reason
        }
            break;
        default:
            return NO;
            break;
    }
    return NO;

}
+ (DataStatus)check:(NSString *)status {
    if( [status isEqualToString:@"00000"])
        return DataStatusSuccess;
    if( [status isEqualToString:@"11001"])
        return DataStatusError;
    if( [status isEqualToString:@"10001"])
        return DataStatusRegisterAlready;
    if( [status isEqualToString:@"00001"])
        return DataStatusInfoNotComplete;
    if( [status isEqualToString:@"10002"])
        return DataStatusTokenIdentifyTimeOut;
    if( [status isEqualToString:@"10003"])
        return DataStatusTypeError;
    if( [status isEqualToString:@"10004"])
        return DataStatusTokenChanged;
    if( [status isEqualToString:@"10005"])
        return DataStatusTokenError;
    if( [status isEqualToString:@"10006"])
        return DataStatusTokenIsNotrefreshToken;

    return DataStatusError;
}
@end
