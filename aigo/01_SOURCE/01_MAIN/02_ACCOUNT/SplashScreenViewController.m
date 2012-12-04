//
//  SplashScreenViewController.m
//  VISIKARD
//
//  Created by Huu Vinh Huynh on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "UserDataManager.h"
#import "AppViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController
@synthesize imageViewLoading = _imageViewLoading;

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
    _APIRequester = [APIRequester new];
    
    NSMutableArray *arrayLoading = [NSMutableArray new];
    for (int i=1; i<=16; i++) {
        NSString *strImage = [[NSString alloc] initWithFormat:@"loading_bar%i.png", i];
        UIImage *image = [UIImage imageNamed:strImage];
        [arrayLoading addObject:image];
    }
    _imageViewLoading.animationImages = arrayLoading;
    _imageViewLoading.animationRepeatCount = 0;
    _imageViewLoading.animationDuration = TIMER_SPLASH_SCREEN_ANIMATION;
    [_imageViewLoading startAnimating];
    
    if ([UserDataManager Shared].loginStatus) {
        if ([UserDataManager Shared].sessionID.length > 0) {
            NSLog(@"Login: call Logout before");
            
            NSString * strURL = [NSString stringWithFormat:@"%@/%i/%@", STRING_REQUEST_URL_USER_LOGOUT,[UserDataManager Shared].userID, [UserDataManager Shared].sessionID];
            [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_USER_LOGOUT andRootURL:strURL andPostMethodKind:NO andParams:nil andDelegate:self];
            
//            [[AutomationDataManager Shared] reloadAllDataWithDataIsReady:enumAutomationDataIsReady_ForHome_BeforeEntering andDelegate:self];
        }
        else {
            if ([UserDataManager Shared].userName.length > 0 && [UserDataManager Shared].password.length > 0) {
                NSMutableDictionary  *params = [NSMutableDictionary new];
                [params setObject:[UserDataManager Shared].userName forKey:STRING_REQUEST_KEY_USER_NAME_EMAIL];
                [params setObject:[UserDataManager Shared].password forKey:STRING_REQUEST_KEY_PASSWORD];
                
                // MinhPB 2012/11/16
                [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_USER_LOGIN andRootURL:STRING_REQUEST_URL_USER_LOGIN_USERNAME_EMAIL andPostMethodKind:YES andParams:params andDelegate:self];
            }
            else {
                [UserDataManager Shared].loginStatus = NO;
                [[AppViewController Shared] changeBackFromSplashScreen];
            }
        }
    }
    else {
        [UserDataManager Shared].loginStatus = NO;
        [[AppViewController Shared] changeBackFromSplashScreen];
    }
}

- (void)viewDidUnload
{
    [self setImageViewLoading:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    
}

#pragma mark - AutomationDataManagerProtocol

- (void)didRequestFinishedWithDataIsReady:(enumAutomationDataIsReady)isReady {
    [UserDataManager Shared].loginStatus = YES;
    [[UserDataManager Shared] save];
    [[AppViewController Shared] changeBackFromSplashScreen];
}

- (void)didRequestFailedWithDataIsReady:(enumAutomationDataIsReady)isReady {
    [UserDataManager Shared].loginStatus = NO;
    [[UserDataManager Shared] save];
    [[AppViewController Shared] changeBackFromSplashScreen];
}

#pragma mark - APIRequesterProtocol

- (void)requestFinished:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type {
    NSLog(@"requestFinished: %@", [request responseString]);
    
    [[AppViewController Shared] isRequesting:NO andRequestType:type andFrame:CGRectZero];
    
    NSError *error;
    SBJSON *sbJSON = [SBJSON new];
    
    if (![sbJSON objectWithString:[request responseString] error:&error] || request.responseStatusCode != 200 || !request) {
        [UserDataManager Shared].loginStatus = NO;
        [[UserDataManager Shared] save];
        [[AppViewController Shared] changeBackFromSplashScreen];
        
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
        
        if ([UserDataManager Shared].userName.length > 0 && [UserDataManager Shared].password.length > 0) {
            NSMutableDictionary  *params = [NSMutableDictionary new];
            
            // MinhPB 2012/11/21
#if APP_USE_NEW_DESIGNS
            [params setObject:[UserDataManager Shared].userName forKey:STRING_REQUEST_KEY_USER_NAME_EMAIL];
            [params setObject:[UserDataManager Shared].password forKey:STRING_REQUEST_KEY_PASSWORD];
            [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_USER_LOGIN andRootURL:STRING_REQUEST_URL_USER_LOGIN_USERNAME_EMAIL andPostMethodKind:YES andParams:params andDelegate:self];
#else
            [params setObject:[UserDataManager Shared].userName forKey:STRING_REQUEST_KEY_USER_NAME];
            [params setObject:[UserDataManager Shared].password forKey:STRING_REQUEST_KEY_PASSWORD];
            [_APIRequester requestWithType:ENUM_API_REQUEST_TYPE_USER_LOGIN andRootURL:STRING_REQUEST_URL_USER_LOGIN andPostMethodKind:YES andParams:params andDelegate:self];
#endif
        }
        else {
            [UserDataManager Shared].loginStatus = NO;
            [[AppViewController Shared] changeBackFromSplashScreen];
        }
    }
    else if (type == ENUM_API_REQUEST_TYPE_USER_LOGIN) {
        NSMutableArray *jsonData = [sbJSON objectWithString:[request responseString] error:&error];
        if (jsonData.count > 0) {
            NSMutableDictionary *dicJson = [SupportFunction repairingDictionaryWith:[jsonData objectAtIndex:0]];
            if (dicJson) {
                if ([[dicJson objectForKey:STRING_RESPONSE_KEY_MESSAGE_LOGIN] isEqualToString:STRING_RESPONSE_KEY_SUCCESS]) {
                    // KardData
                    [[UserDataManager Shared] cleanUserCacheAndCookie];
                    
                    [UserDataManager Shared].userID = [[dicJson objectForKey:STRING_RESPONSE_KEY_USER_ID] intValue];
                    [UserDataManager Shared].sessionID = [dicJson objectForKey:STRING_RESPONSE_KEY_SESSION_ID];
                    [UserDataManager Shared].loginStatus = YES;
                    [[UserDataManager Shared] save];
                    
                    //// Get user Points/Level Info here////
                    
                    NSString *url = [NSString stringWithFormat:@"%@/%i", STRING_REQUEST_URL_POINTS_GET_LEVEL,[UserDataManager Shared].userID];
                    [_APIRequester requestWithType:(ENUM_API_REQUEST_TYPE_POINTS_GET_All) andRootURL:url andPostMethodKind:NO andParams:nil andDelegate:self];
                    
//                    [[AutomationDataManager Shared] reloadAllDataWithDataIsReady:enumAutomationDataIsReady_ForHome_BeforeEntering andDelegate:self];
                    
                    
                }
                else {
                    [UserDataManager Shared].loginStatus = NO;
                    [[UserDataManager Shared] save];
                    [[AppViewController Shared] changeBackFromSplashScreen];
                    
                    ALERT(@"", [dicJson objectForKey:STRING_RESPONSE_KEY_MESSAGE_LOGIN]);
                }
            }
            else {
                [UserDataManager Shared].loginStatus = NO;
                [[UserDataManager Shared] save];
                [[AppViewController Shared] changeBackFromSplashScreen];
            }
        }
        else {
            [UserDataManager Shared].loginStatus = NO;
            [[UserDataManager Shared] save];
            [[AppViewController Shared] changeBackFromSplashScreen];
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
            [[UserDataManager Shared] save];
        }
       
        [[AutomationDataManager Shared] reloadAllDataWithDataIsReady:enumAutomationDataIsReady_ForHome_BeforeEntering andDelegate:self];
    }
    else {
        [UserDataManager Shared].loginStatus = NO;
        [[UserDataManager Shared] save];
        [[AppViewController Shared] changeBackFromSplashScreen];
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type {
    NSLog(@" requestFailed: %@ ", request.responseString);
    
    [[AppViewController Shared] isRequesting:NO andRequestType:type andFrame:CGRectZero];
    
    if (![ASIHTTPRequest isNetworkReachable]) {
        if ([UserDataManager Shared].loginStatus ==  YES) {
            // support offline mode
            [[AppViewController Shared] changeBackFromSplashScreen];
        } else {
            [[AppViewController Shared] changeBackFromSplashScreen];
            ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_CONNECTION_ERROR);
        }
    } 
    else {
        [UserDataManager Shared].loginStatus = NO;
        [[AppViewController Shared] changeBackFromSplashScreen];
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
    }
}

@end
