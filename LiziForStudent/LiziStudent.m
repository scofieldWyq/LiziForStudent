//
//  LiziStudent.m
//  LiziFirstReleased
//
//  Created by 吴英强 on 15/3/31.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziStudent.h"
//#import "NUPTHttpRequest.h"
//#import "LiziMyClass.h"

@implementation LiziStudent
+ (LiziStudent *)me {
    static LiziStudent *me;
    
    if(! me ) {
        me = [[LiziStudent alloc] init];
    }
    
    return me;
}

//- (void)loadStudentData:(NSData *)data {
//    
//    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    
//    [self  setMyInfoWithName:jsonObject[@"name"] school:jsonObject[@"school"] number:jsonObject[@"number"] email:jsonObject[@"email"] phone:jsonObject[@"phone"] messageCode:jsonObject[@"messageCode"] img:jsonObject[@"img"]];
//    
//    [self coursesAdd:jsonObject[@"subject"]];
//}

- (instancetype)initWithName:(NSString *)name   school:(NSString *)school   number:(NSString *)number   email:(NSString *)email phone:(NSString *)phone messageCode:(NSString *)messageCode img:(NSString *)img {
    self = [super init];
    
    if(self) {
        _name = name;
        _school = school;
        _number = number;
        _email = email;
        _phone = phone;
        _messageCode = messageCode;
        _img = img;
    }
    
    return self;
}

- (void)setMyInfoWithName:(NSString *)name   school:(NSString *)school   number:(NSString *)number   email:(NSString *)email phone:(NSString *)phone messageCode:(NSString *)messageCode img:(NSString *)img {
    
    _name = name;
    _school = school;
    _number = number;
    _email = email;
    _phone = phone;
    _messageCode = messageCode;
    _img = img;
    if(! _courses )
        _courses = [[NSMutableArray alloc] init];
}

//- (void)coursesAdd:(NSArray *)courses {
//    LiziMyClass *c;
//    
//    for (NSDictionary *course in courses) {
//        c = [[LiziMyClass alloc] initWithClassName:course[@"className"] teacher:course[@"teacher"] content:course[@"contentDetails"]];
//        
//        [_courses addObject:c];
//    }
//}

- (NSString *)description {
    return [NSString stringWithFormat:@"\nname : %@\nscholl : %@\nnumber : %@\nemail : %@\nphone : %@\nmessageCode : %@\nimg : %@\n", _name, _school, _number, _email, _phone, _messageCode, _img];
}
@end
