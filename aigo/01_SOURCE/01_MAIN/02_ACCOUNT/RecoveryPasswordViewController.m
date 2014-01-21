//
//  RecoveryPasswordViewController.m
//  trongvm
//
//  Created by Vinh Huynh on 10/2/12.
//
//

#import "RecoveryPasswordViewController.h"
#import "AppViewController.h"
#import "APIRequester.h"

@interface RecoveryPasswordViewController () <APIRequesterProtocol, UITextFieldDelegate, UIAlertViewDelegate>
{
    APIRequester *_requester;
}
@end

@implementation RecoveryPasswordViewController
@synthesize emailField = _emailField;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEmailField:nil];
    [super viewDidUnload];
}

#pragma mark - Actions

- (IBAction)recoveryPasswordAcction:(id)sender {
    [self hideKeyBoard:nil];
    if (_emailField.text.length > 0) {
        _requester = [[APIRequester alloc] init];
        NSMutableDictionary *_param = [NSMutableDictionary dictionaryWithObjectsAndKeys:_emailField.text,@"email", nil];
        [_requester requestWithType:ENUM_API_REQUEST_TYPE_USER_RECOVER_PASSWORD andRootURL:STRING_REQUEST_URL_USER_RECOVERY_PASSWORD andPostMethodKind:YES andParams:_param andDelegate:self];
        [[AppViewController Shared] isRequesting:YES andRequestType:ENUM_API_REQUEST_TYPE_INVALID andFrame:FRAME(0, 0, WIDTH_IPHONE, HEIGHT_IPHONE)];
    }
    else {
        ALERT(@"", STRING_ALERT_ENTER_EMAIL);
    }
}

- (IBAction)cancelAcction:(id)sender {
    [[AppViewController Shared] changeBackFromRecoveryPassword];
}

- (IBAction)hideKeyBoard:(id)sender {
    [_emailField resignFirstResponder];
}

- (void)touchUpInsideBack:(id)sender {
    [[AppViewController Shared] changeBackFromRecoveryPassword];
}

#pragma mark - Text Feild Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_emailField resignFirstResponder];
    return YES;
}

#pragma mark - API Requeter Delegate
- (void)requestFailed:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type
{
    NSLog(@" requestFailed %@ ", request.responseString);
    
    [[AppViewController Shared] isRequesting:NO andRequestType:ENUM_API_REQUEST_TYPE_INVALID andFrame:CGRectZero];
    
    ALERT(STRING_ALERT_TITLE_SORRY, STRING_ALERT_CONNECTION_ERROR);
}

- (void)requestFinished:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type
{
    NSLog(@" requestFinished %@ ", request.responseString);
    [[AppViewController Shared] isRequesting:NO andRequestType:type andFrame:CGRectZero];
    
    NSError *error;
    SBJSON *sbJSON = [SBJSON new];
    
    if (![sbJSON objectWithString:[request responseString] error:&error] || request.responseStatusCode != 200 || !request) {
        ALERT(STRING_ALERT_TITLE_SORRY, STRING_ALERT_SERVER_ERROR);
        return;
    }
    NSArray *jsonArray = [sbJSON objectWithString:[request responseString] error:&error];
    if ([jsonArray count] > 0) {
        if (type ==  ENUM_API_REQUEST_TYPE_USER_RECOVER_PASSWORD) {
            NSDictionary *_dict = [jsonArray objectAtIndex:0];
            if ([[_dict objectForKey:STRING_RESPONSE_KEY_MESSAGE] isEqualToString:STRING_RESPONSE_CODE_SUCCESS]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message: STRING_ALERT_RECOVERY_PASSWORD_SUCCESS delegate:self cancelButtonTitle:STRING_ALERT_OK otherButtonTitles:nil, nil];
                [alert show];
            }
            else
                ALERT(STRING_ALERT_TITLE_SORRY, STRING_ALERT_RECOVERY_PASSWORD_EMAIL_INVALID);
        }
    }
    else {
        ALERT(STRING_ALERT_TITLE_SORRY, STRING_ALERT_RECOVERY_PASSWORD_EMAIL_INVALID);
    }
    
}

#pragma mark -  UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:STRING_ALERT_OK]) {
        [[AppViewController Shared] changeBackFromRecoveryPassword];
    }
}

@end
