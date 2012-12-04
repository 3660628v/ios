//
//  LoginViewController.m
//  VISIKARD
//
//  Created by Phan Ba Minh on 5/30/12.
//  Copyright (c) 2012 kidbaw. All rights reserved.
//

#import "LoginViewController.h"
#import "SBJSON.h"
#import "AppViewController.h"
#import "UserDataManager.h"
#import "RegisterViewController.h"

#define kAlertPasswordOrUserNameIncorect1                  @"Sorry, your username/password combination is incorrect, Please try again.Would you like to recover your password via email?"
#define kAlertPasswordOrUserNameIncorect2                  @"Sorry, your username/password combination is incorrect, Please try again. (Attempt 2/5) Would you like to recover your password via email?"
#define kAlertPasswordOrUserNameIncorect3                  @"Sorry, your username/password combination is incorrect, Please try again. (Attempt 3/5) Would you like to recover your password via email?"
#define kAlertPasswordOrUserNameIncorect4                  @"Sorry, your username/password combination is incorrect, Please try again. (Attempt 4/5) Would you like to recover your password via email?"
#define kAlertPasswordOrUserNameIncorect5                  @"Sorry, you have reached the maximum number of unsuccessful login attempts, please wait 5 minutes and try again, Would you like to recover your password via email?"



#define kLoginFailCounter                                   @"counter"
#define kTimeOut                                            60

@interface LoginViewController ()<UIAlertViewDelegate>
{
    NSUserDefaults *userDefauld;
    CFAbsoluteTime timerCounter; 
}
@end

@implementation LoginViewController
@synthesize loginButton;
@synthesize rememberMeBtn;
@synthesize scrollView;
@synthesize FBButton = _FBButton;
@synthesize TWButton = _TWButton;
@synthesize passView = _passView;
@synthesize useNameView = _useNameView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    userDefauld = [NSUserDefaults standardUserDefaults];
    //[userDefauld setObject:@"0" forKey:kLoginFailCounter];
//    [userDefauld synchronize];
    
    // set font size
    userNameTextField = [[VKWelcomeTextField alloc] initWithFrame:_userNameTemp.frame];
    userNameTextField.placeholder = @"USERNAME / EMAIL";
    userNameTextField.font = [UIFont fontWithName:@"Bebas Neue" size:30];
    userNameTextField.delegate = self;
    userNameTextField.textAlignment = NSTextAlignmentCenter;
    userNameTextField.textColor = [UIColor whiteColor];
    userNameTextField.fontType = enumVKWelcomeTextFieldType_BebasNeue;
    userNameTextField.adjustsFontSizeToFitWidth = YES;
    userNameTextField.returnKeyType = UIReturnKeyNext;
    [_useNameView addSubview:userNameTextField];
    
    passTextField = [[VKWelcomeTextField alloc] initWithFrame:_passTemp.frame];
    passTextField.placeholder = @"PASSWORD";
    passTextField.font = [UIFont fontWithName:@"Bebas Neue" size:30];
    passTextField.delegate = self;
    passTextField.textAlignment = NSTextAlignmentCenter;
    passTextField.textColor = [UIColor whiteColor];
    passTextField.fontType = enumVKWelcomeTextFieldType_BebasNeue;
    passTextField.adjustsFontSizeToFitWidth = YES;
    passTextField.secureTextEntry = YES;
    passTextField.returnKeyType = UIReturnKeyDone;
    [_passView addSubview:passTextField];
    
#ifdef __APPSTORE__R1__
    _FBButton.hidden = YES;
    _TWButton.hidden = YES;
#else
    _FBButton.hidden = NO;
    _TWButton.hidden = NO;
#endif
    
    _APIRequester = [APIRequester new];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:STRING_USER_DEFAULT_USER_LOGIN_REMEBER_ME]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:STRING_USER_DEFAULT_USER_LOGIN_REMEBER_ME] boolValue]) {
            rememberMeBtn.selected = YES;
            if ([[UserDataManager Shared] userID] > 0 && [UserDataManager Shared].userName.length > 0 && [UserDataManager Shared].isLoginWith_FB_TW == NO) {
                userNameTextField.text = [UserDataManager Shared].userName;
                passTextField.text =   [UserDataManager Shared].password;
            }
        }
    }
}

- (void)viewDidUnload
{
    [self setUserNameTemp:nil];
    [self setPassTemp:nil];
    
    [self setRememberMeBtn:nil];
    [self setLoginButton:nil];
    [self setScrollView:nil];
    [self setUseNameView:nil];
    [self setPassView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
}

- (BOOL)checkBeforeLogin {
    if (userNameTextField.text.length == 0) {
		ALERT(@"", @"Please enter your username!");
        [userNameTextField becomeFirstResponder];
        return NO;
    }
    if (passTextField.text.length == 0) {
		ALERT(@"", @"Please enter your password!");
        [passTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}

- (void)login {
    if ([UserDataManager Shared].sessionID.length > 0) {
        NSLog(@"Login: call Logout before");
        
        [[AppViewController Shared] isRequesting:YES andRequestType:ENUM_API_REQUEST_TYPE_USER_LOGOUT andFrame:FRAME(0, 0, [SupportFunction getDeviceWidth], [SupportFunction getDeviceHeight]-HEIGHT_STATUS_BAR)];
        
        NSString * strURL = [NSString stringWithFormat:@"%@/%i/%@", STRING_REQUEST_URL_USER_LOGOUT,[UserDataManager Shared].userID, [UserDataManager Shared].sessionID];
        [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_USER_LOGOUT andRootURL:strURL andPostMethodKind:NO andParams:nil andDelegate:self];
    }
    else {
        NSMutableDictionary  *params = [NSMutableDictionary new];
        if (userNameTextField.text.length > 0) {
            [params setObject:userNameTextField.text forKey:STRING_REQUEST_KEY_USER_NAME_EMAIL];
        }
        if (passTextField.text.length > 0)
            [params setObject:passTextField.text forKey:STRING_REQUEST_KEY_PASSWORD];
        
        [[AppViewController Shared] isRequesting:YES andRequestType:ENUM_API_REQUEST_TYPE_USER_LOGIN andFrame:FRAME(0, 0, [SupportFunction getDeviceWidth], [SupportFunction getDeviceHeight]-HEIGHT_STATUS_BAR)];
        
        // MinhPB 2012/11/16
        [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_USER_LOGIN andRootURL:STRING_REQUEST_URL_USER_LOGIN_USERNAME_EMAIL andPostMethodKind:YES andParams:params andDelegate:self];
    }
    
    // Login many accounts at the same time
//    NSMutableArray *usernameArray = [NSMutableArray arrayWithObjects:@"kwilliams", @"kbuilder", @"f1l1", @"lamha", @"demo", @"khanh", @"TQK666", @"qasim", @"Ndtam", @"tuele", @"masieu", @"stevecarter366", @"thuyduong", @"LongPro", @"ken4s", @"thiends", @"tuele_apic", @"demo123", @"Tester", @"mjpq", @"mikepate", @"tuan", @"tuan1", @"paul", @"phuongphuong", @"masieuvn88", @"sdfsd", @"Quoc Khanh", @"*Quoc*Khanh*", @"adnan123", nil];
//    NSMutableArray *passwordArray = [NSMutableArray arrayWithObjects:@"bonita2k9", @"kbuilder", @"test", @"123456", @"123456Dien", @"123456", @"qqqqqq", @"123456", @"123456", @"mdieple", @"123456", @"melina66", @"chinhuoc", @"123456", @"pass1234", @"123456", @"tuele123898989", @"123456", @"123456", @"qwert", @"qwert", @"qqqqqq", @"aaaaaa", @"pan56kites1", @"123456789", @"123456", @"123456", @"123456", @"123456", @"123456", nil];
//    
//    for (int i=0; i<usernameArray.count; i++) {
//        APIRequester *apiRe = [APIRequester new];
//        NSMutableDictionary  *params = [NSMutableDictionary new];
//        [params setObject:[usernameArray objectAtIndex:i] forKey:STRING_REQUEST_KEY_USER_NAME];
//        [params setObject:[passwordArray objectAtIndex:i] forKey:STRING_REQUEST_KEY_PASSWORD];
//        
//        [apiRe requestWithType:ENUM_API_REQUEST_TYPE_USER_LOGIN andRootURL:STRING_REQUEST_URL_USER_LOGIN andPostMethodKind:YES andParams:params andDelegate:self];
//        [params release];
//    }
}

#pragma mark - Actions

- (IBAction)clickRegister:(id)sender {
    [[AppViewController Shared] changeToRegister];
}

- (IBAction)clickLogin:(id)sender {
//    [ASIFormRequest setPostValue:@"demo123"  forKey:@"username"];
//    [ASIFormRequest setPostValue:@"123456"  forKey:@"password"];
//    [ASIFormRequest setPostValue:@"kwilliams"  forKey:@"username"];
//    [ASIFormRequest setPostValue:@"bonita2k9"  forKey:@"password"];
    
    if ([self checkBeforeLogin]) {
        [self login];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 320, 460) animated:YES];
    }
}

- (IBAction)clickLoginWithFB:(id)sender {
    if (![ASIHTTPRequest isNetworkReachable]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_CONNECTION_ERROR);
        return;
    }
    
    [[AppViewController Shared] changeToFacebookViewController];
}

- (IBAction)clickLoginWithTW:(id)sender {
    if (![ASIHTTPRequest isNetworkReachable]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_CONNECTION_ERROR);
        return;
    }
    
    [[AppViewController Shared] changeToTwitterViewController];
}

- (IBAction)touchUpInsideAround:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 320, 460) animated:YES];
    //[self.scrollView setContentSize:CGSizeMake(WIDTH_IPHONE, HEIGHT_IPHONE - HEIGHT_STATUS_BAR)];
    [self.scrollView setScrollEnabled:NO];
}

- (IBAction)touchDownButton:(id)sender {
    NSLog(@" touchDownButton ");
    UIButton *button=(UIButton *)sender;
    button.highlighted = NO;
}

- (IBAction)touchUpButton:(id)sender {
    NSLog(@" touchUpButton ");
    UIButton *button=(UIButton *)sender;
    
    if (button.selected) {
        button.selected = NO;
    }
    else {
        button.selected = YES;
    }
    
    button.highlighted = NO;
}

- (IBAction)touchUpInsideBack:(id)sender {
    [[AppViewController Shared] changeBackFromLogin];
}

- (void)update
{
    if (CFAbsoluteTimeGetCurrent() - timerCounter >= 5 * kTimeOut) {
        loginButton.enabled = YES;
        [userDefauld setObject:@"0" forKey:kLoginFailCounter];
        [userDefauld synchronize];
    }
}

#pragma mark - APIRequesterProtocol

- (void)requestFinished:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type {
//    NSLog(@"requestFinished: %@", [request responseString]);
    
    [[AppViewController Shared] isRequesting:NO andRequestType:type andFrame:CGRectZero];
    
    NSError *error;
    SBJSON *sbJSON = [SBJSON new];
    
    if (![sbJSON objectWithString:[request responseString] error:&error] || request.responseStatusCode != 200 || !request) {
//        if (![ASIHTTPRequest isNetworkReachable]) {
//            ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
//        }
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
        return;
    }
    
    if (type == ENUM_API_REQUEST_TYPE_USER_LOGOUT) {
        [UserDataManager Shared].sessionID = @"";
        [UserDataManager Shared].loginStatus = NO;
        [[UserDataManager Shared] save];
        
        NSMutableDictionary  *params = [NSMutableDictionary new];
        if (userNameTextField.text.length > 0) {
            [params setObject:userNameTextField.text forKey:STRING_REQUEST_KEY_USER_NAME_EMAIL];
        }
        if (passTextField.text.length > 0)
            [params setObject:passTextField.text forKey:STRING_REQUEST_KEY_PASSWORD];
        
        [[AppViewController Shared] isRequesting:YES andRequestType:type andFrame:FRAME(0, 0, [SupportFunction getDeviceWidth], [SupportFunction getDeviceHeight] - HEIGHT_STATUS_BAR)];
        
        // MinhPB 2012/11/16
        [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_USER_LOGIN andRootURL:STRING_REQUEST_URL_USER_LOGIN_USERNAME_EMAIL andPostMethodKind:YES andParams:params andDelegate:self];
    }
    else if (type == ENUM_API_REQUEST_TYPE_USER_LOGIN)
    {
        NSMutableArray *jsonData = [sbJSON objectWithString:[request responseString] error:&error];
        if (jsonData.count > 0) {
            NSMutableDictionary *dicJson = [SupportFunction repairingDictionaryWith:[jsonData objectAtIndex:0]];
            if (dicJson) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", rememberMeBtn.selected] forKey:STRING_USER_DEFAULT_USER_LOGIN_REMEBER_ME];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                if ([[dicJson objectForKey:STRING_RESPONSE_KEY_MESSAGE_LOGIN] isEqualToString:STRING_RESPONSE_KEY_SUCCESS]) {
                    // RESET User's Old Data
                    [userDefauld setObject:@"0" forKey:kLoginFailCounter];
                    [userDefauld synchronize];
                    NSLog(@"%@", jsonData);
                    [[UserDataManager Shared] resetAllData];
                    
                    [UserDataManager Shared].userID = [[dicJson objectForKey:STRING_RESPONSE_KEY_USER_ID] intValue];
                    [UserDataManager Shared].sessionID = [dicJson objectForKey:STRING_RESPONSE_KEY_SESSION_ID];
                    [UserDataManager Shared].userName = [dicJson objectForKey:STRING_RESPONSE_KEY_USER_NAME];
                    [UserDataManager Shared].password = passTextField.text;
                    [UserDataManager Shared].loginStatus = YES;
                    [UserDataManager Shared].isLoginWith_FB_TW = NO;
                    [UserDataManager Shared].avatarSmallURL = @"";
                    [[UserDataManager Shared] save];
                    
                    //// Get user Points/Level Info here////
                    
                    [[AppViewController Shared] isRequesting:YES andRequestType:type andFrame:FRAME(0, 0, [SupportFunction getDeviceWidth], [SupportFunction getDeviceHeight] - HEIGHT_STATUS_BAR)];
                    
                    NSString *url = [NSString stringWithFormat:@"%@/%i", STRING_REQUEST_URL_POINTS_GET_LEVEL,[UserDataManager Shared].userID];
                    [_APIRequester requestWithType:(ENUM_API_REQUEST_TYPE_POINTS_GET_All) andRootURL:url andPostMethodKind:NO andParams:nil andDelegate:self];
                    
//                    [[AutomationDataManager Shared] reloadAllDataWithDataIsReady:enumAutomationDataIsReady_ForHome_BeforeEntering andDelegate:self];
                }
                else {
                    
                    ALERT(@"", [dicJson objectForKey:STRING_RESPONSE_KEY_MESSAGE_LOGIN]);
                }
            }
        }
        else {
            NSInteger counter = [[userDefauld objectForKey:kLoginFailCounter] intValue];
            counter =  counter + 1;
            [userDefauld setObject:[NSString stringWithFormat:@"%i", counter] forKey:kLoginFailCounter];
            [userDefauld synchronize];
            NSString *message = nil;
            switch (counter) {
                case 1:
                    message = kAlertPasswordOrUserNameIncorect1;
                    timerCounter = CFAbsoluteTimeGetCurrent();
                    break;
                case 2:
                    if (CFAbsoluteTimeGetCurrent() - timerCounter <= kTimeOut) {
                        message = kAlertPasswordOrUserNameIncorect2;
                    }
                    else {
                        [userDefauld setObject:[NSString stringWithFormat:@"%i", counter] forKey:kLoginFailCounter];
                        message = kAlertPasswordOrUserNameIncorect1;
                        timerCounter = CFAbsoluteTimeGetCurrent();
                    }
                    break;
                case 3:{
                    if (CFAbsoluteTimeGetCurrent() - timerCounter <= kTimeOut) {
                        message = kAlertPasswordOrUserNameIncorect3;
                    }
                    else {
                        [userDefauld setObject:[NSString stringWithFormat:@"%i", counter] forKey:kLoginFailCounter];
                        message = kAlertPasswordOrUserNameIncorect1;
                        timerCounter = CFAbsoluteTimeGetCurrent();
                    }
                }
                    break;
                case 4:{
                    if (CFAbsoluteTimeGetCurrent() - timerCounter <= kTimeOut) {
                        message = kAlertPasswordOrUserNameIncorect4;
                    }
                    else {
                        [userDefauld setObject:[NSString stringWithFormat:@"%i", counter] forKey:kLoginFailCounter];
                        message = kAlertPasswordOrUserNameIncorect1;
                        timerCounter = CFAbsoluteTimeGetCurrent();
                    }
                }
                    break;
                case 5:{
                    if (CFAbsoluteTimeGetCurrent() - timerCounter <= kTimeOut) {
                        message =  kAlertPasswordOrUserNameIncorect5;
                        [loginButton setEnabled:NO];
                    }
                    else {
                        [userDefauld setObject:[NSString stringWithFormat:@"%i", counter] forKey:kLoginFailCounter];
                        message = kAlertPasswordOrUserNameIncorect1;
                        timerCounter = CFAbsoluteTimeGetCurrent();
                    }
                }
                    break;
                default:
                    message = STRING_ALERT_SERVER_ERROR;
                    break;
            }
            
            alertViewWrongFields = [[UIAlertView alloc] initWithTitle:STRING_ALERT_TITLE_SORRY message:message delegate:self cancelButtonTitle:STRING_ALERT_YES otherButtonTitles:STRING_ALERT_NO, nil];
            [alertViewWrongFields show];
        }
    }
    else if (type == ENUM_API_REQUEST_TYPE_POINTS_GET_All) {
        
        NSMutableArray *jsonData = [sbJSON objectWithString:[request responseString] error:&error];
        if (jsonData.count > 0) {
            NSMutableDictionary *dicJson = [SupportFunction repairingDictionaryWith:[jsonData objectAtIndex:0]];
            
            [UserDataManager Shared].userTotalPoints = [[dicJson valueForKey:@"totalPoint"] intValue];
            [UserDataManager Shared].userCurrentPoints = [[dicJson valueForKey:@"currentPoint"] intValue];
            [UserDataManager Shared].userLevel = [[dicJson valueForKey:@"levelUser"] intValue];
            [UserDataManager Shared].userRank = [dicJson valueForKey:@"ranks"];
        }
        
        // MinhPB 2012/09/10: POINTS & REWARDS
        [[AppViewController Shared] isRequesting:YES andRequestType:type andFrame:FRAME(0, 0, [SupportFunction getDeviceWidth], [SupportFunction getDeviceHeight] - HEIGHT_STATUS_BAR)];
        [[AutomationDataManager Shared] reloadAllDataWithDataIsReady:enumAutomationDataIsReady_ForHome_BeforeEntering andDelegate:self];
    }
    else if (type == ENUM_API_REQUEST_TYPE_USER_FORGET_PASSWORD) {
        
        NSMutableArray *jsonData = [sbJSON objectWithString:[request responseString] error:&error];
        if (jsonData.count > 0) {
            NSMutableDictionary *dicJson = [SupportFunction repairingDictionaryWith:[jsonData objectAtIndex:0]];
            if ([[dicJson objectForKey:STRING_RESPONSE_KEY_MESSAGE] isEqualToString:STRING_RESPONSE_KEY_SUCCESS]) {
                // Email has sent
                ALERT(@"", STRING_ALERT_RECOVERY_PASSWORD_SUCCESS);
            }
            else if ([[dicJson objectForKey:STRING_RESPONSE_KEY_MESSAGE] isEqualToString:STRING_RESPONSE_KEY_INVALID]) {
                // Email is invalid
                ALERT(STRING_ALERT_TITLE_SORRY, STRING_ALERT_RECOVERY_PASSWORD_EMAIL_INVALID);
            }
            else if ([[dicJson objectForKey:STRING_RESPONSE_KEY_MESSAGE] isEqualToString:STRING_RESPONSE_KEY_EMPTY]) {
                // Username is invalid
                alertViewNotExitUsername = UI_ALERT_VIEW(STRING_ALERT_LOGIN_USER_NAME_INVALID, STRING_ALERT_LOGIN_RECOVERY_PASSWORD_SCREEN_REQUIRED, self, STRING_ALERT_NO, STRING_ALERT_YES);
                [alertViewNotExitUsername show];
            }
            else if ([[dicJson objectForKey:STRING_RESPONSE_KEY_MESSAGE] isEqualToString:STRING_RESPONSE_KEY_FAILURE]) {
                // Server
                ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
            }
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type {
//    NSLog(@" requestFailed %@ ", request.responseString);
    
    [[AppViewController Shared] isRequesting:NO andRequestType:type andFrame:CGRectZero];
    
    if (![ASIHTTPRequest isNetworkReachable]) {
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_CONNECTION_ERROR);
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"shouldChangeCharactersInRange: textField:%@, string: %@", textField.text, string);
    if([string isEqualToString:@""])
        return YES; // always allow delete
    
    if(textField.text.length - range.length + string.length > 30)
        return NO;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == userNameTextField)
    {
        [passTextField becomeFirstResponder];
    }
    else if(textField == passTextField)
    {
        if ([loginButton isEnabled]) {
            if ([self checkBeforeLogin]) {
                [passTextField resignFirstResponder];
                [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 320, 460) animated:YES];
                [self login];
            }
        }
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.scrollView setScrollEnabled:NO];
    [self.scrollView setContentSize:CGSizeMake(320, 500)];
    [self.scrollView scrollRectToVisible:CGRectMake(0, 50, 320, 460) animated:YES];
    return YES;
}

#pragma mark - AutomationDataManagerProtocol

- (void)didRequestFinishedWithDataIsReady:(enumAutomationDataIsReady)isReady {
    if (isReady == enumAutomationDataIsReady_ForHome_BeforeEntering) {
        [[AppViewController Shared] isRequesting:NO andRequestType:ENUM_API_REQUEST_TYPE_INVALID andFrame:CGRectZero];
        [[AppViewController Shared] changeToHomeFromWelcomeScreen:YES];
    }
}

- (void)didRequestFailedWithDataIsReady:(enumAutomationDataIsReady)isReady {
    if (isReady == enumAutomationDataIsReady_ForHome_BeforeEntering) {
        [[AppViewController Shared] isRequesting:NO andRequestType:ENUM_API_REQUEST_TYPE_INVALID andFrame:CGRectZero];
        [UserDataManager Shared].loginStatus = NO;
    }
}

#pragma mark - AlertView Delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:STRING_ALERT_YES] && alertView == alertViewWrongFields) {
        // MinhPB 2012/11/12
//        [[AppViewController Shared] changeToRecoveryPassword];
        
        [[AppViewController Shared] isRequesting:YES andRequestType:ENUM_API_REQUEST_TYPE_USER_FORGET_PASSWORD andFrame:FRAME(0, 0, [SupportFunction getDeviceWidth], [SupportFunction getDeviceHeight]-HEIGHT_STATUS_BAR)];
        
        NSString *strURL = [NSString stringWithFormat:@"%@/%@", STRING_REQUEST_URL_USER_FORGET_PASSWORD, userNameTextField.text];
        [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_USER_FORGET_PASSWORD andRootURL:strURL andPostMethodKind:NO andParams:nil andDelegate:self];
    }
    else if ([title isEqualToString:STRING_ALERT_YES] && alertView == alertViewNotExitUsername) {
        // MinhPB 2012/11/12
        [[AppViewController Shared] changeToRecoveryPassword];
    }
}

@end
