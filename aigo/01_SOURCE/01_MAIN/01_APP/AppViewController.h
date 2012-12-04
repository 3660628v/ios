//
//  ViewController.h
//  aigo
//
//  Created by Tai Truong on 11/20/12.
//  Copyright (c) 2012 AIGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CoreData/CoreData.h"
#import "Define.h"
#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserDataManager.h"
#import "ClientMainViewController.h"
#import "FBLoginManager.h"
#import "TWLoginManager.h"
#import "FBFunLoginManager.h"
#import "SplashScreenViewController.h"
#import "RecoveryPasswordViewController.h"
#import "DriverMainViewController.h"

@interface AppViewController : UIViewController {
    NSMutableArray                                  *_listOfViewController;
    UIView                                          *_requestingView;
    UIActivityIndicatorView                         *_requestingIndicator;
}
+ (AppViewController *)Shared;

#pragma mark - Indicator view animation
- (void)isRequesting:(BOOL)isRe andRequestType:(ENUM_API_REQUEST_TYPE)type andFrame:(CGRect)frame;

#pragma mark - App Protocol
- (void)update;

#pragma mark - Home View Controller
- (void)changeToHomeFromWelcomeScreen:(BOOL)isFromLogin;
- (void)changeBackToHome;

#pragma mark - Splash Screen View Controller
- (void)changeToSplashScreen;
- (void)changeBackFromSplashScreen;

#pragma mark - Welcome
- (void)changeToWelcome;
- (void)changeBackToWelcome;

#pragma mark - Login & Register
- (void)changeToLogin;
- (void)changeBackFromLogin;

- (void)changeToRegister;
- (void)changeBackFromRegister;

- (void)changeToRecoveryPassword;
- (void)changeBackFromRecoveryPassword;

#pragma mark - Facebook & Twitter
- (void)changeToFacebookViewController;
- (void)chageBackFromFacebookViewController;
- (void)changeToTwitterViewController;
- (void)chageBackFromTwitterViewController;

#pragma mark - UIImage Picker View Controller
- (void)changeToPickerControllerWithSourceType:(UIImagePickerControllerSourceType)type andDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate;
- (void)changeBackFromPickerController;

@end
