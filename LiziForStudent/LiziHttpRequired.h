//
//  LiziHttpRequired.h
//  LiziForTeacher
//
//  Created by 吴英强 on 15/4/14.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ProcessState) {
    ProcessStateLogin = 0,
    ProcessStateRegister = 1,
    ProcessStateRefresh = 2,
    ProcessStateAddClass = 3,
    ProcessStateStudentClassAdd = 4,
    ProcessStatePostMessage = 5,
    ProcessStatePostRelpy = 6,
    ProcessStateCheckMessage = 7,
    ProcessStateCheckReply = 8,
    ProcessStateCheckClassmates = 9,
    ProcessStateSearchClass = 10,
    ProcessStateCourseTable = 11,
    ProcessStateAddCode = 12,
    ProcessStateRollCall = 13,
    ProcessStateCheckAttendSec = 14,
    
};

@protocol dataReceive <NSObject>
-(void)loginCompleted;
-(void)registerCompleted;
@end
@interface LiziHttpRequired : NSObject
@property (nonatomic, strong) NSDictionary *getData;
@property (nonatomic, strong) id<dataReceive> dataDelegate;
+ (LiziHttpRequired *)getInstance;
- (void)loginNowWithName:(NSString *)name   password:(NSString *)pw viewController:(UIViewController *)vC;

- (void)registerNowWithPhone:(NSString *)phone code:(NSString *)password name:(NSString *)name email:(NSString *)mail device:(NSString *)devices viewController:(UIViewController *)vC ;
- (void)checkMessageInViewController:(UIViewController *)vC;

@end
