//
//  NUPTChangePhoneInformation.h
//  LiziPage
//
//  Created by 吴英强 on 15/3/16.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUPTChangePhoneInformation : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *changedCode;
@property (weak, nonatomic) IBOutlet UITextField *Phone;
@property (nonatomic, weak) IBOutlet UIView *sendEmailView;
@property (nonatomic, weak) IBOutlet UIView *updateInfoView;
@end
