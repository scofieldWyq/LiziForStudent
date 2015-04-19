//
//  LiziHttpRequired.m
//  LiziForTeacher
//
//  Created by 吴英强 on 15/4/14.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziHttpRequired.h"
@interface LiziHttpRequired() <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) UIViewController *view_controller;
@property (nonatomic) ProcessState status;
@property (nonatomic, strong) UIActivityIndicatorView *progress;
@property (nonatomic, strong) UIView *temp;

@property (nonatomic, strong) NSString *logURL;
@property (nonatomic, strong) NSString *regURL;
@property (nonatomic, strong) NSString *checkMessageURL;

@property (nonatomic, strong) NSString *accessToken;

@end
@implementation LiziHttpRequired

+ (LiziHttpRequired *)getInstance {
    static LiziHttpRequired *progress;
    
    if(! progress) {
        progress = [[LiziHttpRequired alloc] init];
    }
    return progress;
}

- (instancetype)init {
    self = [super init];
    
    if(self) {
        self.logURL = @"http://192.168.2.201:1984/lizi/login/";
        self.regURL = @"http://192.168.2.201:1984/lizi/reg/";
        self.checkMessageURL = @"http://192.168.2.201:1984/lizi/checkMessage/";
        //do something.
    }
    
    return self;
}


/*
 not complete yet.
 
- (void)checkMessageInViewController:(UIViewController *)vC {
    self.view_controller = vC;
    
    NSURL *Url = [NSURL URLWithString:self.checkMessageURL];
    
    NSString *post = [NSString stringWithFormat:@"AccessToken=%@&user_type=%@&course_id=%@", self.accessToken, @"t", name, mail, devices];
    
    NSData *code = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:Url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:code];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection) {
        if( self.data)//clean data....
            self.data = nil;
        
        self.data = [NSMutableData new];
        
        self.status = ProcessStateCheckMessage;
        
        [self watingNow:self.view_controller];
    }
}
 */
- (void)registerNowWithPhone:(NSString *)phone code:(NSString *)password name:(NSString *)name email:(NSString *)mail device:(NSString *)devices viewController:(UIViewController *)vC {
    
    self.view_controller = vC;
    
    NSURL *Url = [NSURL URLWithString:self.regURL];
    
    NSString *post = [NSString stringWithFormat:@"phone_number=%@&password=%@&real_name=%@&mail=%@&device_token=%@", phone, password, name, mail, devices];
    
    NSData *code = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:Url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:code];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection) {
        if( self.data)//clean data....
            self.data = nil;
        
        self.data = [NSMutableData new];
        
        self.status = ProcessStateRegister;
        
        [self watingNow:self.view_controller];
    }
    
    
}
- (void)loginNowWithName:(NSString *)name password:(NSString *)pw  viewController:(UIViewController *)vC{
    
    self.view_controller = vC;
    
    NSURL *Url = [NSURL URLWithString:self.logURL];
    
    NSString *post = [NSString stringWithFormat:@"phone_number=%@&password=%@",name,pw];
    
    NSData *code = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:Url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:code];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection) {
        if( self.data)
            self.data = nil;
        
        self.data = [NSMutableData new];
        
        self.status = ProcessStateLogin;
        
        [self watingNow:self.view_controller];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self watingCompleted];
    NSLog(@"%@", [error localizedDescription]);
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [self watingCompleted];
    
    self.getData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil];
    
    switch (self.status) {
        case ProcessStateLogin: {
            
            /*
             *test data prints
             */
            NSLog(@"%@", self.getData);
            /*
             */
            
        }
            break;
        case ProcessStateRegister: {
            
            /*
             *test data prints
             */
            NSLog(@"%@", self.getData);
            /*
             */
        }
            break;
        default:
            break;
    }
    
    [self.dataDelegate loginCompleted];
    
}

- (void)watingNow:(UIViewController *)viewController
/*
 * wate for server data.
 */
{
    //add a view to let user know that they are wating...
    self.temp = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, CGRectGetWidth( viewController.view.frame), CGRectGetHeight(viewController.view.frame))];
    [self.temp setHidden:YES];
    [self.temp setBackgroundColor:[UIColor lightGrayColor]];//set the color.
    [self.temp setAlpha:0];//alpha 0.5
    
    //create a progress.
    self.progress = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //set the progress center.
    self.progress.center = CGPointMake( CGRectGetWidth(viewController.view.frame)/2 , CGRectGetHeight(viewController.view.frame) / 2);
    [self.temp addSubview:self.progress];
    [self.progress startAnimating];//start progress.
    
    [UIView animateWithDuration:0.75 animations:^{
        [self.temp setHidden:NO];
        [self.temp setAlpha:0.5];
    }];
    
    [viewController.view addSubview:self.temp];
}

- (void)watingCompleted
/*
 * get data from server completed...
 */
{
    
    /* remove progress */
    [self.progress stopAnimating];
    [self.progress removeFromSuperview];
    self.progress = nil;
    
    /* view remove */
    [UIView animateWithDuration:0.75 animations:^{
        [self.temp setAlpha:0];
    } completion:^(BOOL finished) {
        [self.temp setHidden:NO];
    }];
    [self.temp removeFromSuperview];
    self.temp = nil;
    
}

@end
