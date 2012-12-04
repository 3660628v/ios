//
//  NewRegisterViewController.h
//  visi_register
//
//  Created by Tai Truong on 11/15/12.
//  Copyright (c) 2012 Tai Truong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKWelcomeTextField.h"

#define REGISTER_EMAIL_PLACEHOLDER_STR @"EMAIL"
#define REGISTER_PASSWORD_PLACEHOLDER_STR @"PASSWORD"
#define REGISTER_FIELD_HEIGH 35
#define REGISTER_EXPANDED_FIELD_HEIGH 74
#define REGISTER_SAVEBTN_DETAL_Y 8

typedef enum {
    enum_age_10_14 = 100,
    enum_age_15_19,
    enum_age_20_30,
    enum_age_31_44,
    enum_age_45_54,
    enum_age_55_64,
    enum_age_over_65,
    enum_age_count
}enum_age;

typedef enum {
    enum_gender_female = 1000,
    enum_gender_male,
    enum_gender_count
}enum_gender;

@interface RegisterViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate>
// properties
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet VKWelcomeTextField *emailTextField;
@property (strong, nonatomic) IBOutlet VKWelcomeTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTemp;
@property (weak, nonatomic) IBOutlet UITextField *userNameTemp;
@property (weak, nonatomic) IBOutlet UILabel *facebookLabel;
@property (weak, nonatomic) IBOutlet UIButton *facebookBtn;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;
@property (weak, nonatomic) IBOutlet UIButton *twitterBtn;
@property (weak, nonatomic) IBOutlet UIView *ageView;
@property (weak, nonatomic) IBOutlet UIView *ageSelectorView;
@property (weak, nonatomic) IBOutlet UIButton *ageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *ageViewBackground;
@property (weak, nonatomic) IBOutlet UILabel *accountSectionLbl;
@property (weak, nonatomic) IBOutlet UILabel *profileSectionLbl;

@property (weak, nonatomic) IBOutlet UIView *genderView;
@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UIView *genderSelectorView;
@property (weak, nonatomic) IBOutlet UIImageView *genderViewBackground;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (assign, nonatomic) enum_age age;
@property (assign, nonatomic) enum_gender gender;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

// term view
@property (strong, nonatomic) IBOutlet UIView *termsView;
@property (weak, nonatomic) IBOutlet UIWebView *termConditionWebView;

// actions
- (IBAction)termOfServiceTouchUpInside:(UIButton *)sender;
- (IBAction)saveTouchUpInside:(UIButton *)sender;
- (IBAction)facebookBtnTouchUpInside:(UIButton *)sender;
- (IBAction)twitterBtnTouchUpInside:(UIButton *)sender;

// age selector action
- (IBAction)ageSelectorTouchUpInside:(UIButton*)sender;
- (IBAction)ageBtnTouchUpInside:(UIButton *)sender;
// gender selector action
- (IBAction)genderSelectorTouchUpInside:(UIButton *)sender;
- (IBAction)genderBtnTouchUpInside:(UIButton *)sender;


- (IBAction)backBtnTouchUpInside:(UIButton *)sender;
- (IBAction)termBtnTouchUpInside:(UIButton *)sender;

- (void)updateInfoFromFacebook:(NSDictionary*)params;
- (void)updateInfoFromTwitter:(NSDictionary*)params;
@end
