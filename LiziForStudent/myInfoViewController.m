//
//  myInfoViewController.m
//  Testing
//
//  Created by 吴英强 on 15/3/29.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "myInfoViewController.h"
#import "Tools.h"
#import "LiziStudent.h"
#import "LiziStudent.h"

typedef NS_ENUM(NSInteger, SexSelected) {
    SexSelectedBoy = 0,
    SexSelectedGirl = 1,
    SexSelectedNone = 2
};

@interface myInfoViewController()
//text
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *myId;

@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *name;

//edit text
@property (weak, nonatomic) IBOutlet UITextField *editName;
@property (weak, nonatomic) IBOutlet UITextField *editSchool;
@property (weak, nonatomic) IBOutlet UITextField *editMyId;
@property (weak, nonatomic) IBOutlet UITextField *editEmail;

@property (weak, nonatomic) IBOutlet UIButton *sex_Girl;
@property (weak, nonatomic) IBOutlet UIButton *sex_Boy;
@property (weak, nonatomic) IBOutlet UIButton *sex_none;
@property (weak, nonatomic) IBOutlet UIImageView *myPhoto;

@property (weak, nonatomic) IBOutlet UIView *myInformationView;

@property (nonatomic) float photoCenterX;
@property (nonatomic) float sexCenterX;
@property (nonatomic) SexSelected sex;
@property (nonatomic) BOOL hide;

@end
@implementation myInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* prepare for something */
    [self prepareMyInformation];
    
    /* set the defualt sex */
    _photoCenterX = _myPhoto.center.x;
    _sexCenterX = _sex_Boy.center.x;
    
    /* set some action */
    [_sex_Boy addTarget:self action:@selector(boy:) forControlEvents:UIControlEventTouchUpInside];
    [_sex_Girl addTarget:self action:@selector(girl:) forControlEvents:UIControlEventTouchUpInside];
    [_sex_none addTarget:self action:@selector(none:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loadMyInformation
/*
 * load data in view.
 */
{
    // not load yet.
    //load data.
    /*
     * set myId.text
     * set school.text
     * set name.text
     * set email.text
     *
     */
    
}

- (void)changeData
/*
 * when the edit mode done.
 */
{
    LiziStudent *stu = [LiziStudent me];
    
    [stu setName:_editName.text];
    [stu setSchool:_editSchool.text];
    [stu setNumber:_editMyId.text];
    [stu setEmail:_editEmail.text];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self prepareMyInfo];
}

- (void)prepareMyInfo {
    LiziStudent *student = [LiziStudent me];
    
    [_name setText:student.name];
    [_school setText:student.school];
    [_myId setText:student.number];
    [_email setText:student.email];
    
}
- (void)boy:(UIButton *)sender{
    if( _hide ) {
        
        [self showPhotoEdit];
    } else {
    
        [self resizedSexAndPhotoWithSex:SexSelectedBoy];
    
        [_sex_Boy setEnabled:YES];
        [_sex_Girl setEnabled:NO];
        [_sex_none setEnabled:NO];
    }
    
    
}
- (void)girl:(UIButton *)sender {
    if( _hide ) {
        
        [self showPhotoEdit];
    } else {
    
        [self resizedSexAndPhotoWithSex:SexSelectedGirl];
        [_sex_Girl setEnabled:YES];
        [_sex_Boy setEnabled:NO];
        [_sex_none setEnabled:NO];

    }
    
    
}
- (void)none:(UIButton *)sender {
    if( _hide ) {
        
        [self showPhotoEdit];
    } else {
    
        [self resizedSexAndPhotoWithSex:SexSelectedNone];
    
        [_sex_none setEnabled:YES];
        [_sex_Boy setEnabled:NO];
        [_sex_Girl setEnabled:NO];
    }
    
    _hide = YES;
}

- (void)prepareMyInformation{
    
    [_sex_Boy setEnabled:NO];
    [_sex_Girl setEnabled:NO];
    [_sex_none setEnabled:NO];
    
    [_sex_Boy setHidden:NO];
    [_sex_Girl setHidden:YES];
    [_sex_none setHidden:YES];
    
    [Tools prepareCustomeView:_myInformationView forAttantion:NO];
    
    [Tools prepareCustomeTextField:_editName delegate:self withLeftView:nil];
    [Tools prepareCustomeTextField:_editSchool delegate:self withLeftView:nil];
    [Tools prepareCustomeTextField:_editMyId delegate:self withLeftView:nil];
    [Tools prepareCustomeTextField:_editEmail delegate:self withLeftView:nil];
    
    [_editEmail setHidden:YES];
    [_editEmail setEnabled:NO];
    
    [_editMyId setHidden:YES];
    [_editMyId setEnabled:NO];
    
    [_editSchool setHidden:YES];
    [_editSchool setEnabled:NO];
    
    [_editName setHidden:YES];
    [_editName setEnabled:NO];
    
    _sex = SexSelectedBoy;
    _hide = YES;
    
    [self loadMyInformation];
    
}

- (void)editMode {
    
    _hide = NO;
    
    [_email setHidden:YES];
    [_school setHidden:YES];
    [_name setHidden:YES];
    [_myId setHidden:YES];
    
    [_editEmail setHidden:NO];
    [_editEmail setEnabled:YES];
    
    [_editMyId setHidden:NO];
    [_editMyId setEnabled:YES];
    
    [_editSchool setHidden:NO];
    [_editSchool setEnabled:YES];
    
    [_editName setHidden:NO];
    [_editName setEnabled:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        _myPhoto.center = CGPointMake(_photoCenterX - 55, _myPhoto.center.y);
        
        [_sex_Boy setHidden:NO];
        _sex_Boy.center = CGPointMake(_sexCenterX - 60, _sex_Boy.center.y);
        
        [_sex_Girl setHidden:NO];
        _sex_Girl.center = CGPointMake(_sexCenterX - 30, _sex_Girl.center.y);
        
        [_sex_none setHidden:NO];
        
    } completion:^(BOOL finished) {
        
        [_sex_Boy setEnabled:YES];
        [_sex_Girl setEnabled:YES];
        [_sex_none setEnabled:YES];
        
        [_sex_Boy setBackgroundImage:[UIImage imageNamed:@"boy_pressed"] forState:UIControlStateHighlighted];
        [_sex_Girl setBackgroundImage:[UIImage imageNamed:@"girl_pressed"] forState:UIControlStateHighlighted];
        [_sex_none setBackgroundImage:[UIImage imageNamed:@"secret_pressed"] forState:UIControlStateHighlighted];
        
    }];
    
    
    
    
}
- (void)noEditMode {
    
    [_editEmail setHidden:YES];
    
    [_editMyId setHidden:YES];

    [_editSchool setHidden:YES];
    
    [_editName setHidden:YES];
    
    
    if( ! _hide) {
        [self resizedSexAndPhotoWithSex:_sex];
    }
    
    [_editEmail setEnabled:NO];
    [_editMyId setEnabled:NO];
    [_editSchool setEnabled:NO];
    [_editName setEnabled:NO];
    
    [_email setHidden:NO];
    [_school setHidden:NO];
    [_name setHidden:NO];
    [_myId setHidden:NO];
    
    [_sex_Boy setEnabled:NO];
    [_sex_Girl setEnabled:NO];
    [_sex_none setEnabled:NO];
}

- (void)resizedSexAndPhotoWithSex:(SexSelected )sex {
 
    _sex = sex;
    
    [UIView animateWithDuration:0.5 animations:^{
        _myPhoto.center = CGPointMake(_photoCenterX , _myPhoto.center.y);
        
        
        _sex_Boy.center = CGPointMake(_sexCenterX , _sex_Boy.center.y);
        
        
        _sex_Girl.center = CGPointMake(_sexCenterX , _sex_Girl.center.y);
        
    } completion:^(BOOL finished) {
        
        if(sex != SexSelectedBoy) {
            [_sex_Boy setHidden:YES];
        }
        if( sex != SexSelectedGirl) {
            [_sex_Girl setHidden:YES];
        }
        if( sex != SexSelectedNone) {
            [_sex_none setHidden:YES];
        }
 
    }];
    
    _hide = YES;
}

- (void)setProperty {
    
    if( [_editName.text isEqual:@""] || [_editSchool.text isEqual:@""] || [_editMyId.text isEqual:@""] || [ _editEmail isEqual:@""]) {
        
        return ;
    }
    
    else {
        _name.text = _editName.text;
        _school.text = _editSchool.text;
        _myId.text = _editMyId.text;
        _email.text = _editEmail.text;
        [self changeData];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)showPhotoEdit {
    
    [UIView animateWithDuration:0.5 animations:^{
        _myPhoto.center = CGPointMake(_photoCenterX - 55, _myPhoto.center.y);
        
        [_sex_Boy setHidden:NO];
        _sex_Boy.center = CGPointMake(_sexCenterX - 60, _sex_Boy.center.y);
        
        [_sex_Girl setHidden:NO];
        _sex_Girl.center = CGPointMake(_sexCenterX - 30, _sex_Girl.center.y);
        
        [_sex_none setHidden:NO];
        
    } completion:^(BOOL finished) {
        
        [_sex_Boy setEnabled:YES];
        [_sex_Girl setEnabled:YES];
        [_sex_none setEnabled:YES];
        
        [_sex_Boy setBackgroundImage:[UIImage imageNamed:@"boy_pressed"] forState:UIControlStateHighlighted];
        [_sex_Girl setBackgroundImage:[UIImage imageNamed:@"girl_pressed"] forState:UIControlStateHighlighted];
        [_sex_none setBackgroundImage:[UIImage imageNamed:@"secret_pressed"] forState:UIControlStateHighlighted];
        _hide = NO;
        
    }];

}
@end
