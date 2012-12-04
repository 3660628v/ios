//
//  ViewController.m
//  aigo
//
//  Created by Tai Truong on 11/20/12.
//  Copyright (c) 2012 AIGO. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

@implementation AppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _listOfViewController = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 100, 30)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////////////////////////
static AppViewController *_appVCInstance;
+ (AppViewController *)Shared
{
    if (!_appVCInstance) {
        _appVCInstance = [[AppViewController alloc] init];
    }
    return _appVCInstance;
}

#pragma mark - Indicator view animation

- (void)isRequesting:(BOOL)isRe andRequestType:(ENUM_API_REQUEST_TYPE)type andFrame:(CGRect)frame {
    if (isRe) {
        if (_requestingView == nil) {
            _requestingView = [UIView new];
            _requestingView.backgroundColor = [UIColor blackColor];
            _requestingView.alpha= 0.5;
        }
        if (_requestingIndicator == nil) {
            _requestingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [_requestingView addSubview:_requestingIndicator];
            
        }
        
        [_requestingView removeFromSuperview];
        [_requestingIndicator startAnimating];
		_requestingView.frame = frame;
		_requestingIndicator.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [[[_listOfViewController lastObject] view] addSubview:_requestingView];
    }
    else {
        [_requestingIndicator stopAnimating];
        [_requestingView removeFromSuperview];
    }
}

#pragma mark - App Protocol
/////////////////////////////////
- (void)update {
    // update top view controller
    if ([_listOfViewController lastObject]) {
        id<AppViewControllerProtocol> vc = [_listOfViewController lastObject];
        if ([vc respondsToSelector:@selector(update)]) {
            [vc update];
        }
    }
    
    // Request API server automatically
    if ([[AutomationDataManager Shared] respondsToSelector:@selector(update)]) {
        [[AutomationDataManager Shared] update];
    }
}

#pragma mark - Home View Controller
/////////////////////////////////
- (void)changeToHomeFromWelcomeScreen:(BOOL)isFromLogin {
    if (isFromLogin) {
        [_listOfViewController removeAllObjects];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }

#ifdef __RELEASE__PRODUCTION1__
    // CLIENT
    ClientMainViewController *clientVC = [ClientMainViewController new];
    [_listOfViewController addObject:clientVC];
    [self.navigationController pushViewController:clientVC animated:YES];
#else
    // DRIVER
    ClientMainViewController *clientVC = [ClientMainViewController new];
    [_listOfViewController addObject:clientVC];
    [self.navigationController pushViewController:clientVC animated:YES];
#endif

}
- (void)changeBackToHome {
    [_listOfViewController removeAllObjects];
    
    CATransition* transition = [CATransition animation];
    transition.duration = TIMER_CHANGING_VIEW;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [_listOfViewController removeAllObjects];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
#ifdef __RELEASE__PRODUCTION1__
    // CLIENT
    ClientMainViewController *clientVC = [ClientMainViewController new];
    [_listOfViewController addObject:clientVC];
    [self.navigationController pushViewController:clientVC animated:YES];
#else
    // DRIVER
    ClientMainViewController *clientVC = [ClientMainViewController new];
    [_listOfViewController addObject:clientVC];
    [self.navigationController pushViewController:clientVC animated:YES];
#endif
}

#pragma mark - Splash Screen View Controller
/////////////////////////////////
- (void)changeToSplashScreen {
    SplashScreenViewController *tempVC = [SplashScreenViewController new];
    
    [_listOfViewController addObject:tempVC];
    [self.navigationController pushViewController:tempVC animated:NO];
}
- (void)changeBackFromSplashScreen {
    [_listOfViewController removeLastObject];
    [self.navigationController popViewControllerAnimated:NO];
    
    // MinhPB 2012/11/20
    [self changeToWelcome];
}

#pragma mark - Welcome
/////////////////////////////////
- (void)changeToWelcome {
    if ([UserDataManager Shared].loginStatus) {
        [self changeToHomeFromWelcomeScreen:NO];
    }
    else {
        WelcomeViewController *tempVC = [WelcomeViewController new];
        
        [_listOfViewController addObject:tempVC];
        [self.navigationController pushViewController:tempVC animated:NO];
    }
}
- (void)changeBackToWelcome {
    [_listOfViewController removeAllObjects];
    
    CATransition* transition = [CATransition animation];
    transition.duration = TIMER_CHANGING_VIEW;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    WelcomeViewController *welcomeVC = [WelcomeViewController new];
    
    [_listOfViewController addObject:welcomeVC];
    [self.navigationController pushViewController:welcomeVC animated:NO];
}

#pragma mark - Login & Register
/////////////////////////////////
- (void)changeToLogin {
    LoginViewController *tempVC = [LoginViewController new];
    
    [_listOfViewController addObject:tempVC];
    [self.navigationController pushViewController:tempVC animated:YES];
}
- (void)changeBackFromLogin {
    [_listOfViewController removeLastObject];
    [self.navigationController popViewControllerAnimated:YES];
}

/////////////////////////////////
- (void)changeToRegister {
    RegisterViewController *tempVC = [RegisterViewController new];
    
    [_listOfViewController addObject:tempVC];
    [self.navigationController pushViewController:tempVC animated:YES];
}
- (void)changeBackFromRegister {
    [_listOfViewController removeLastObject];
    [self.navigationController popViewControllerAnimated:YES];
}

/////////////////////////////////
- (void)changeToRecoveryPassword
{
    RecoveryPasswordViewController *reVC = [RecoveryPasswordViewController new];
    [_listOfViewController addObject:reVC];
    [self.navigationController pushViewController:reVC animated:YES];
}
- (void)changeBackFromRecoveryPassword
{
    [_listOfViewController removeLastObject];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Facebook & Twitter

- (void)changeToFacebookViewController {
    [[FBFunLoginManager Shared] reLogin];
    
    [_listOfViewController addObject:[[FBFunLoginManager Shared] getFBControllerWithDelegate:self]];
    [self.navigationController pushViewController:[[FBFunLoginManager Shared] getFBControllerWithDelegate:self] animated:YES];
}

- (void)chageBackFromFacebookViewController {
    if ([FBFunLoginManager Shared].loginStatus) {
        [_listOfViewController removeLastObject];
        [self.navigationController popViewControllerAnimated:NO];
        
		if ([FBFunLoginManager Shared].fName == nil || [FBFunLoginManager Shared].lName == nil || [FBFunLoginManager Shared].userID == nil) {
			ALERT(@"chageBackFromFacebookViewController", STRING_ALERT_DATA_IS_NIL);
			return;
		}
		
		NSMutableDictionary  *params = [NSMutableDictionary new];
        [params setObject:[FBFunLoginManager Shared].fName forKey:STRING_REQUEST_KEY_F_NAME];
		[params setObject:[FBFunLoginManager Shared].lName forKey:STRING_REQUEST_KEY_L_NAME];
		[params setObject:[FBFunLoginManager Shared].email forKey:STRING_REQUEST_KEY_EMAIL];
        [params setObject:[FBFunLoginManager Shared].gender forKey:STRING_REQUEST_KEY_GENDER];
        [params setObject:[FBFunLoginManager Shared].about forKey:STRING_REQUEST_KEY_ABOUT];
        if([FBFunLoginManager Shared].birthday)
        {
            NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                               components:NSYearCalendarUnit
                                               fromDate:[FBFunLoginManager Shared].birthday
                                               toDate:[FBFunLoginManager Shared].updateTime
                                               options:0];
            NSInteger age = [ageComponents year];
            // set age
            [params setObject:[NSNumber numberWithInt:age] forKey:STRING_REQUEST_KEY_AGE];
        }
        else
        {
            [params setObject:[NSNumber numberWithInt:-1] forKey:STRING_REQUEST_KEY_AGE];
        }
        
        RegisterViewController *registryViewController = (RegisterViewController*)[_listOfViewController lastObject];
        [registryViewController updateInfoFromFacebook:params];
        //        [[APIRequester Shared] requestWithType:ENUM_API_REQUEST_TYPE_USER_LOGIN_WITH_FB_TW andRootURL:STRING_REQUEST_URL_USER_LOGIN_WITH_FB_TW andPostMethodKind:YES andParams:params andDelegate:self];
        //
        //		[[AppViewController Shared] isRequesting:YES andRequestType:ENUM_API_REQUEST_TYPE_USER_LOGIN_WITH_FB_TW andFrame:FRAME(0, 0, [SupportFunction getDeviceWidth], [SupportFunction getDeviceHeight] - HEIGHT_STATUS_BAR)];
    }
    else {
        [_listOfViewController removeLastObject];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/////////////////////////////////
- (void)changeToTwitterViewController {
    [[TWLoginManager Shared] reLogin];
    
    [_listOfViewController addObject:[[TWLoginManager Shared] getTWControllerWithDelegate:self]];
    [self.navigationController pushViewController:[[TWLoginManager Shared] getTWControllerWithDelegate:self] animated:YES];
}

- (void)chageBackFromTwitterViewController {
    if ([TWLoginManager Shared].loginStatus) {
        [_listOfViewController removeLastObject];
        [self.navigationController popViewControllerAnimated:NO];
        
		if ([TWLoginManager Shared].userName == nil) {
			ALERT(@"chageBackFromTwitterViewController", STRING_ALERT_DATA_IS_NIL);
			return;
		}
		
		NSMutableDictionary  *params = [NSMutableDictionary new];
        [params setObject:[TWLoginManager Shared].name forKey:STRING_REQUEST_KEY_F_NAME];
		[params setObject:@"" forKey:STRING_REQUEST_KEY_L_NAME];
		[params setObject:STRING_ID_TW_FORMATTER([TWLoginManager Shared].userID) forKey:STRING_REQUEST_KEY_EMAIL];
        [params setObject:[TWLoginManager Shared].gender forKey:STRING_REQUEST_KEY_GENDER];
        [params setObject:[TWLoginManager Shared].about forKey:STRING_REQUEST_KEY_ABOUT];
        
        RegisterViewController *registryViewController = (RegisterViewController*)[_listOfViewController lastObject];
        [registryViewController updateInfoFromTwitter:params];
    }
    else {
        [_listOfViewController removeLastObject];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIImage Picker View Controller

- (void)changeToPickerControllerWithSourceType:(UIImagePickerControllerSourceType)type andDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate {
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = type;
        picker.delegate = delegate;
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] && type == UIImagePickerControllerSourceTypeCamera) {
            picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        [self presentModalViewController:picker animated:NO];
    }
    else {
        ALERT(@"", STRING_ALERT_MESSAGE_CAMERA_PHOTO_NOT_SUPPORTED);
    }
}
- (void)changeBackFromPickerController {
    [self dismissModalViewControllerAnimated:NO];
}

@end
