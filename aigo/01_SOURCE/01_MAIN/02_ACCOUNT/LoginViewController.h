//
//  LoginViewController.h
//  VISIKARD
//
//  Created by Phan Ba Minh on 5/30/12.
//  Copyright (c) 2012 kidbaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIRequester.h"
#import "AutomationDataManager.h"
#import "VKWelcomeTextField.h"

@interface LoginViewController : UIViewController <APIRequesterProtocol, UITextFieldDelegate, AutomationDataManagerProtocol, UITextViewDelegate> {
    APIRequester                    *_APIRequester;
    
    UIAlertView                     *alertViewWrongFields;
    UIAlertView                     *alertViewNotExitUsername;
    
    VKWelcomeTextField              *userNameTextField;
    VKWelcomeTextField              *passTextField;
}

@property (retain, nonatomic) IBOutlet UITextField          *userNameTemp;
@property (retain, nonatomic) IBOutlet UITextField          *passTemp;
@property (retain, nonatomic) IBOutlet UIButton             *loginButton;
@property (retain, nonatomic) IBOutlet UIButton             *rememberMeBtn;
@property (retain, nonatomic) IBOutlet UIScrollView         *scrollView;
@property (retain, nonatomic) IBOutlet UIButton             *FBButton;
@property (retain, nonatomic) IBOutlet UIButton             *TWButton;
@property (retain, nonatomic) IBOutlet UIView               *useNameView;
@property (retain, nonatomic) IBOutlet UIView               *passView;

- (IBAction)clickRegister:(id)sender;
- (IBAction)clickLogin:(id)sender;
- (IBAction)clickLoginWithFB:(id)sender;
- (IBAction)clickLoginWithTW:(id)sender;
- (IBAction)touchUpInsideAround:(id)sender;
- (IBAction)touchDownButton:(id)sender;
- (IBAction)touchUpButton:(id)sender;
- (IBAction)touchUpInsideBack:(id)sender;

@end
