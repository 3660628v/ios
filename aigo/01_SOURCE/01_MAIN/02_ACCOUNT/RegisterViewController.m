//
//  NewRegisterViewController.m
//  visi_register
//
//  Created by Tai Truong on 11/15/12.
//  Copyright (c) 2012 Tai Truong. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppViewController.h"
#import "Define.h"
#import "APIRequester.h"
#import "JSON.h"
#import "UserDataManager.h"

#define IMG_ERROR            @"register_field_error.png"
#define IMG_SUCCESS          @"register_field_success.png"

#define kLeastName           1
#define kTooLongName         32
#define kLeastUserName       2
#define kTooLongUserName     20
#define kLeastPassword       6
#define kTooLongPassword     36

#define kAlertFirstNameErrorEmpty           @"Please enter a first name."
#define kAlertFirstNameErrorTooLong         @"Sorry, your firt name is just too long!  Please enter a first name 32 characters or less."
#define kAlertFirstNameErrorFormat          @"Sorry, please enter a first name with only standard letters a-z, space, or hyphen."
#define kAlertLastNameErrorEmpty            @"Please enter a last name."
#define kAlertLastNameErrorTooLong          @"Sorry, your last name is just too long!  Please enter a last name 32 characters or less."
#define kAlertLastNameErrorFormat           @"Sorry, please enter a last name with only standard letters a-z, space, or hyphen."
#define kAlertUserNameErrorLeast            @"Please enter a username of at least 2 characters"
#define kAlertUserNameErrorTooLong          @"Sorry, your username is just too long!  Please enter a username 20 characters or less."
#define kAlertUserNameErrorFormat           @"Sorry, please enter a username with only standard letters a-z, standard numbers 0-9,  or hyphen."
#define kAlertEmailErrorFormat              @"Sorry, we need a valid email address.  Please try again."
#define kAlertPasswordNotMatch              @"Passwords did not match.  Please try again."
#define kAlertPasswordFormat                @"Please enter a password between 6 and 20 characters in length."
#define kAlertEmptyField                    @"You must fill in all of the fields."
#define kAlertInavtionCodeInvalid           @"Sorry, invation Code must be 8 characters"

typedef enum {
    enumTagInvalid,
    enumTagEmailAlert
}enunTag;

typedef enum
{
    ENUM_FIELD_CHECK_FIRST_NAME,
    ENUM_FIELD_CHECK_LAST_NAME,
    ENUM_FIELD_CHECK_USER_NAME,
    ENUM_FIELD_CHECK_EMAIL,
    ENUM_FIELD_CHECK_PASSWORK,
    ENUM_FIELD_CHECK_FIELD_EMPTY,
    ENUM_FIELD_CHECK_INVATION_CODE
}ENUM_FIELD_CHECK;

@interface RegisterViewController ()

@end

@implementation RegisterViewController
{
    APIRequester                        *requester;
    NSInteger                           checkBoxFlag;
    UIAlertView                         *registerAlert;
}
@synthesize age = _age;
@synthesize gender = _gender;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize emailTextField;
@synthesize passwordTextField;

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
    
    _age = enum_age_count;
    _gender = enum_gender_count;
    _firstName = @"";
    _lastName = @"";
    self.saveBtn.enabled = NO;
    // set font of all controll
    
    UIFont *font = [UIFont fontWithName:@"Bebas Neue" size:30.0f];
//    [self.emailTextField setFont:font];
//    [self.passwordTextField setFont:font];
    [self.facebookLabel setFont:font];
    [self.twitterLabel setFont:font];
    [self.ageBtn.titleLabel setFont:font];
    [self.genderBtn.titleLabel setFont:font];
    font = [UIFont fontWithName:@"Bebas Neue" size:18.0f];
    [self.accountSectionLbl setFont:font];
    [self.profileSectionLbl setFont:font];
    // age lable font
    font = [UIFont fontWithName:@"Bebas Neue" size:16.0f];
    for (NSInteger i = enum_age_10_14; i < enum_age_count; i++) {
        UILabel *lbl = (UILabel*)[self.view viewWithTag:(i + 100)];
        if (lbl) {
            [lbl setFont:font];
        }
    }
    // gender lable font
    font = [UIFont fontWithName:@"Bebas Neue" size:24.0f];
    for (NSInteger i = enum_gender_female; i < enum_gender_count; i++) {
        UILabel *lbl = (UILabel*)[self.view viewWithTag:(i + 100)];
        if (lbl) {
            [lbl setFont:font];
        }
    }
    
    // init requester
    requester = [[APIRequester alloc] init];
    
    // reinit email and password text field
    emailTextField = [[VKWelcomeTextField alloc] initWithFrame:_userNameTemp.frame];
    emailTextField.placeholder = REGISTER_EMAIL_PLACEHOLDER_STR;
    emailTextField.font = [UIFont fontWithName:@"Bebas Neue" size:30];
    emailTextField.delegate = self;
    emailTextField.textAlignment = NSTextAlignmentCenter;
    emailTextField.textColor = [UIColor whiteColor];
    emailTextField.fontType = enumVKWelcomeTextFieldType_BebasNeue;
    emailTextField.adjustsFontSizeToFitWidth = YES;
    emailTextField.returnKeyType = UIReturnKeyNext;
    [_containerView addSubview:emailTextField];
    
    passwordTextField = [[VKWelcomeTextField alloc] initWithFrame:_passTemp.frame];
    passwordTextField.placeholder = REGISTER_PASSWORD_PLACEHOLDER_STR;
    passwordTextField.font = [UIFont fontWithName:@"Bebas Neue" size:30];
    passwordTextField.delegate = self;
    passwordTextField.textAlignment = NSTextAlignmentCenter;
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.fontType = enumVKWelcomeTextFieldType_BebasNeue;
    passwordTextField.adjustsFontSizeToFitWidth = YES;
    passwordTextField.secureTextEntry = YES;
    [_containerView addSubview:passwordTextField];
    
    // init accessory view for text view
    UIView *av = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT_IPHONE - HEIGHT_IPHONE_KEYBOARD - 60)];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard:)];
    [av addGestureRecognizer:tapGesture];
    [emailTextField setInputAccessoryView:av];
    
    av = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT_IPHONE - HEIGHT_IPHONE_KEYBOARD - 60)];
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard:)];
    [av addGestureRecognizer:tapGesture];
    [passwordTextField setInputAccessoryView:av];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton Actions
// age actions
- (IBAction)ageSelectorTouchUpInside:(UIButton*)sender {
    if(sender.selected)
    {
        [self ageBtnTouchUpInside:self.ageBtn];
        return;
    }
    // reset select status of all age buttons
    for (NSInteger i = enum_age_10_14; i < enum_age_count; i++) {
        UIButton *btn = (UIButton*)[self.view viewWithTag:i];
        btn.selected = NO;
        UILabel *ageLabel = (UILabel*)[self.view viewWithTag:(i + 100)];
        if (ageLabel) {
            [ageLabel setTextColor:[UIColor whiteColor]];
        }
    }
    
    _age = sender.tag;
    UILabel *ageLabel = (UILabel*)[self.view viewWithTag:(sender.tag + 100)];
    if (ageLabel) {
        [ageLabel setTextColor:[SupportFunction colorFromHexString:@"#8CC63E"]];
        [self.ageBtn setTitle:ageLabel.text forState:UIControlStateNormal];
    }
    
    sender.selected = YES;
    
    [self ageBtnTouchUpInside:self.ageBtn];
    // validate info
    [self validateInfo];
}
- (IBAction)ageBtnTouchUpInside:(UIButton *)sender {
    [self dismissAllKeyboard];
    
    sender.selected = !sender.selected;
    BOOL isIphone5 = NO;
    if(self.genderBtn.selected) // age view is expanding
    {
        // collape age view first
        [self resetGenderView];
        isIphone5 = YES;
    }
    
    NSString *imgName = @"welcome_field.png";
    CGFloat temp = 1;
    CGFloat selectorOpacity = 1.0f;
    if(sender.selected) // expand view
    {
        imgName = @"welcome_fieldExp.png";
        temp = 1;
        self.ageSelectorView.hidden = NO;
        self.ageSelectorView.alpha = 0.0f;
    }
    else { // collape view
        imgName = @"welcome_field.png";
        temp = -1;
        selectorOpacity = 0.0f;
    }
    
    UIImage *expandFieldImage = [UIImage imageNamed:imgName];
    CGSize expandSize = expandFieldImage.size;
    [self.ageViewBackground setImage:expandFieldImage];
    // resize age view
    CGRect rect = self.ageView.frame;
    rect.size = expandSize;
    
    CGFloat delta = REGISTER_EXPANDED_FIELD_HEIGH - REGISTER_FIELD_HEIGH;
    CGRect genderRect = self.genderView.frame;
    genderRect.origin.y += temp * delta;
    
    CGRect saveBtnRect = self.saveBtn.frame;
    if (!isIphone5) {
        saveBtnRect.origin.y += temp * REGISTER_SAVEBTN_DETAL_Y;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
                        self.ageView.frame = rect;
                        self.genderView.frame = genderRect;
                        self.saveBtn.frame = saveBtnRect;
                        self.ageSelectorView.alpha = selectorOpacity;
                    }
                     completion:^(BOOL finished) {
                         self.ageSelectorView.hidden = !sender.selected;
                     }];
}

// gender actions
- (IBAction)genderSelectorTouchUpInside:(UIButton *)sender {
    if(sender.selected)
    {
        // collape gender field
        [self genderBtnTouchUpInside:self.genderBtn];
        return;
    }
    
    for (NSInteger i = enum_gender_female; i < enum_gender_count; i++) {
        UIButton *btn = (UIButton*)[self.view viewWithTag:i];
        btn.selected = NO;
    }
    sender.selected = YES;
    
    _gender = sender.tag;
    UILabel *ageLabel = (UILabel*)[self.view viewWithTag:(sender.tag + 100)];
    if (ageLabel) {
        [self.genderBtn setTitle:ageLabel.text forState:UIControlStateNormal];
    }
    
    // collape gender field
    [self genderBtnTouchUpInside:self.genderBtn];
    
    // validate info
    [self validateInfo];
}

- (IBAction)genderBtnTouchUpInside:(UIButton *)sender {
    [self dismissAllKeyboard];
    
    sender.selected = !sender.selected;
    BOOL isIphone5 = NO;
    if(self.ageBtn.selected) // age view is expanding
    {
        // collape age view first
        [self resetAgeView];
        isIphone5 = YES;
    }

    NSString *imgName = @"welcome_field.png";
    CGFloat temp = 1;
    CGFloat selectorOpacity = 1.0f;
    if(sender.selected) // expand view
    {
        imgName = @"welcome_fieldExp.png";
        temp = 1;
        self.genderSelectorView.hidden = NO;
        self.genderSelectorView.alpha = 0.0f;
    }
    else { // collape view
        imgName = @"welcome_field.png";
        temp = -1;
        selectorOpacity = 0.0f;
    }
    
    UIImage *expandFieldImage = [UIImage imageNamed:imgName];
    CGSize expandSize = expandFieldImage.size;
    [self.genderViewBackground setImage:expandFieldImage];
    // resize age view
    CGRect rect = self.genderView.frame;
    rect.size = expandSize;
    
    CGRect saveBtnRect = self.saveBtn.frame;
    if (!isIphone5) {
        saveBtnRect.origin.y += temp * REGISTER_SAVEBTN_DETAL_Y;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
                        self.genderView.frame = rect;
                        self.saveBtn.frame = saveBtnRect;
                        self.genderSelectorView.alpha = selectorOpacity;
                    }
                     completion:^(BOOL finished) {
                         self.genderSelectorView.hidden = !sender.selected;
                     }];
}

- (IBAction)backBtnTouchUpInside:(UIButton *)sender {
    [[AppViewController Shared] changeBackFromRegister];
}

- (IBAction)termBtnTouchUpInside:(UIButton *)sender {
    CGRect rect = self.termsView.frame;
    rect.origin.y = HEIGHT_IPHONE;
    [UIView animateWithDuration:0.3f animations:^{
        self.termsView.frame = rect;
    }
     completion:^(BOOL finished) {
         [self.termsView removeFromSuperview];
     }
     ];
}

- (IBAction)termOfServiceTouchUpInside:(UIButton *)sender {
    NSLog(@"termOfServiceTouchUpInside");
    [self.termsView setHidden:NO];
    [_termConditionWebView loadHTMLString:@"<html><head><title> Term & Codition </title></head> <body><div class=\"Terms-Conditions\"><h1 style=\"text-align:center;\">VisiKard Terms &amp; Conditions</h1>     <p>     You agree that by registering on VisiKard, by using our mobile application or our website or accessing other information provided as part of the VisiKard services (collectively “VisiKard” or the “Services”), you are entering into a legally binding agreement with VisiKard, Inc., having its principal office located at 2839 Paces Ferry Road, Suite 1100, Atlanta, Georgia 30339 USA.  If you reside in the United States (“we,” “us,” “our,” and “VisiKard”) based on VisiKard’s Terms &amp; Conditions and the VisiKard Privacy Policy, which is incorporated herein by reference (collectively referred to as the “Agreement”) and become a VisiKard user (“User”).     </p>     <p>     If you are using VisiKard on behalf of a company or other legal entity, you are individually bound by this Agreement even if your company has a separate agreement with us. If you do not want to register an account and become a VisiKard User, stop here, do NOT click “register” and do not access, view, download or otherwise use any VisiKard application, webpage, information or services. By clicking “register” you acknowledge that you are at least 13 years of age and have read and understood the terms and conditions of this Agreement and that you agree to be bound by all of its provisions. Please note that the VisiKard Terms &amp; Conditions and Privacy Policy are also collectively referred to as VisiKard’s “User Agreement.”     </p>     <h3> USER OBLIGATIONS.</h3>     <ul class=\"number-buidlet\">     <li>     <p>     1.  You must comply with all applicable laws, the Agreement, as may be amended from time to time with or without advance notice, and the policies and processes explained in the following sections:     </p>     <ul class=\"alphabe-buidlet\">     <li>     a) DOs and DON’Ts;     </li>     <li>     b) Complaints Regarding Content Posted; and     </li>     <li>     c) VisiKard’s Privacy Policy.     </li>     </ul>          </li>     <li>     <p>	2.  You own the information you provide VisiKard under this Agreement, and may delete such content at any time, unless you have shared information or content with others and they have not deleted it, or it was copied or stored by other users. Additionally, you grant VisiKard a nonexclusive, irrevocable, worldwide, perpetual, unlimited, assignable, sublicenseable, fully paid up and royalty-free right to us to copy, prepare derivative works of, improve, distribute, publish, remove, retain, add, process, analyze, use and commercialize, in any way now known or in the future discovered, any information you provide, directly or indirectly to VisiKard, including, but not limited to, any user generated content, ideas, concepts, techniques or data to the services, you submit to VisiKard, without any further consent, notice and/or compensation to you or to any third parties.     </p>     <p>     By uploading information on our mobile application, or WebPages, you represent and warrant that you are entitled to submit the information and that the information is accurate, not confidential, and not in violation of any contractual restrictions or other third party rights. It is your responsibility to keep your VisiKard profile information accurate and updated.     </p>     </li>     <li>     <h3>3. Eligibility.</h3>     <p>     To be eligible to use the Service, you must meet the following criteria and represent and warrant that you: (1) are 13 years of age or older; (2) are not currently restricted from the Services, or not otherwise prohibited from having a VisiKard account, (3) are not a competitor of VisiKard or are not using the Services for reasons that are in competition with VisiKard; (4) have full power and authority to enter into this Agreement and doing so will not violate any other agreement to which you are a party; (5) will not violate any rights of VisiKard, including intellectual property rights such as copyright or trademark rights.     </p>     </li>     <li>     <h3>4. Log-In</h3>     <p>     You agree to: (1) Keep your password secure and confidential; (2) not permit others to use your account; (3) refrain from using other Users’ accounts; (4) you are responsible for anything that happens through your account until you close down your account or show written proof that your account security was compromised due to no fault of your own.     </p>     </li>     <li>     <h3>5. Indemnification.</h3>     <p>You indemnify VisiKard and hold VisiKard harmless for all damages, losses and costs (including, but not limited to, reasonable attorneys’ fees and costs) related to all third party claims, charges, and investigations, caused by (1) your failure to comply with this Agreement, including, without limitation, your submission of content that violates third party rights or applicable laws, (2) any content you submit to the Services, and (3) any activity in which you engage on or through VisiKard. </p>     </li>     <li>     <h3>6. VisiKard Applications.</h3>     <p>VisiKard may offer the Services through applications built using VisiKard’s platform (“VisiKard Applications”). Examples of VisiKard Applications include its smart phone applications (VisiKard for iPhone, Android, or Blackberry), and VisiKard’s “Share” buttons and other interactive plug-in distributed on websites across the web. VisiKard Applications are distinct from third party Platform Applications, you agree that information about you and your use of the Services, including, but not limited to, your device, your mobile carrier, your internet access provider, your physical location, and/or web pages containing VisiKard plug-in that load in your browser may be communicated to us. </p>     <p>     You also agree that by importing any data through the VisiKard Application, you represent that you have authority to share the transferred data with your mobile carrier or other access provider. In the event you change or deactivate your mobile account, you must promptly update your VisiKard account information to ensure that your messages are not sent to the person that acquires your old number and failure to do so is your responsibility. You acknowledge you are responsible for all charges and necessary permissions related to accessing VisiKard through your mobile access provider. Therefore, you should check with your provider to find out if the Services are available and the terms for these services for your specific mobile devices as well as any data usage fees.     </p>     <p>     Finally, by using any downloadable application to enable your use of the Services, you are explicitly confirming your acceptance of the terms of the End User License Agreement associated with the application provided at download or installation, or as may be updated from time to time.     </p>     </li>     <li>     <h3>7. Kards, Trading, Sharing, Konnect, Deals</h3>     <p>     VisiKard offers various environments such as My Kards, Konnect, Deals where you may share or trade your Kards, post comments, find deals or Konnect with others. VisiKard also enables sharing of information by allowing users to post updates and other content to their profile and other areas of its sites, such as VisiKard Konnect and MyKards as well as VisiKard WebPages. </p>     <p>     Please note that information you share may be seen and used by other Users, and VisiKard cannot guarantee that other Users will not use the information that you share on VisiKard. Therefore, if you have information that you would like to keep confidential and/or don’t want others to use, make certain that you select the “visible”  “off” settings within the application or webpage. Kards that you have shared with other users in the past will have access to any new information that you post to them.          </p>          </li>     <li>     <h3>8. Privacy.</h3>     <p>     Our Privacy Policy is incorporated herein and your acceptance to “register” as a VisiKard user is your   agreement to such Privacy Policy and governs our treatment of any information, including personally identifiable information you submit to us. Please note that certain information, statements, data, and content (such as photographs) which you may upload or submit to VisiKard are likely to, reveal your gender, ethnic origin, nationality, age, and/or other personal information about you. You acknowledge that your submission of any information, statements, data, and content to us is voluntary on your part.     </p>     </li>     <li>     <h3>9. Idea Submissions to VisiKard</h3>     <p>     By submitting ideas, suggestions, documents, and/or proposals (\"Submissions\") to you acknowledge and agree that: (a) your Contributions do not contain confidential or proprietary information; (b) VisiKard is not under any obligation of confidentiality, express or implied, with respect to the Contributions; (c) VisiKard shall be entitled to use or disclose (or choose not to use or disclose) such Contributions for any purpose, in any way, in any media worldwide; (d) VisiKard may have something similar to the Contributions already under consideration or in development; (e) you irrevocably assign to VisiKard all rights to your Contributions; and (f) you are not entitled to any compensation or reimbursement of any kind from VisiKard under any circumstances.     </p>     </li>     <li>     <h3> 10. YOUR RIGHTS.</h3>     <p>     On the condition that you comply with all your obligations under this Agreement, including, but not limited to, the Do’s and Don’ts listed in Section 22, we grant you a limited, revocable, nonexclusive, nonassignable, nonsublicenseable license and right to access the Services, through a generally available mobile device web browser,  or application (but not through automated tools such as: scraping, spidering, crawling or other technology or software used to access data without the express written consent of VisiKard or its Users), view information and use the Services that we provide on VisiKard’s application, and/or WebPages and in accordance with this Agreement. Any other use of VisiKard contrary to our mission and purpose (such as seeking to connect to someone you do not know or trust, or to use information gathered from VisiKard commercially unless expressly authorized by VisiKard) is strictly prohibited and a violation of this Agreement. We reserve all rights not expressly granted in this Agreement, including, without limitation, title, ownership, intellectual property rights, and all other rights and interest in VisiKard and all related items, including any and all copies made of the VisiKard products.     </p>     </li>     <li>     <h3>11. OUR RIGHTS AND OBLIGATIONS.</h3>     <p>     Services - For as long as VisiKard continues to offer its platform, VisiKard shall provide and seek to update, improve and expand its services. As a result, we allow you to access VisiKard as it may exist and be available on any given day and have no other obligations, except as expressly stated in this Agreement. We may modify, replace, refuse access to, suspend or discontinue VisiKard, partially or entirely, or change and modify prices for all or part of the Services for you or for all our users in our sole discretion. All of these changes shall be effective upon an application update or upon their posting on our sites or by direct communication to you unless otherwise noted. VisiKard further reserves the right to withhold, remove and or discard any content available as part of your account, with or without notice if deemed by VisiKard to be contrary to this Agreement. For avoidance of doubt, VisiKard has no obligation to store, maintain or provide you a copy of any content that you or other Users provide when using the Services.     </p>     </li>     <li>     <h3>12. Third Party Sites  </h3>     <p>     VisiKard may include links to third party sites (“Third Party Sites”) on our mobile app or on VisiKard WebPages (www.VisiKard.com). VisiKard also enables third party developers (“Platform Developers”) to create applications (“Platform Applications”) that provide features and functionality using data and developer tools made available by VisiKard through its developer platform.     </p>     <p>     You are responsible for evaluating whether you want to access or use a Third Party Site or Platform Application. You should review any applicable terms and/or privacy policy of a Third Party Site or Platform Application before using it or sharing any information with it, because you may give the operator permission to use your information in ways we would not.     </p>     <p>     VisiKard is not responsible for, and does not endorse, any features, content, advertising, products or other materials on or available from Third Party Sites or Platform Applications. VisiKard also does not screen, audit, or endorse Platform Applications. Accordingly, if you decide to access Third Party Sites or use Platform Applications, you do so at your own risk and agree that your use of any Platform Application is on an “as-is” basis without any warranty as to the Platform Developer’s actions, and that this Agreement does not apply to your use of any Third Party Site or Developer Application.     </p>     <p>     Please note: If you allow a Platform Application or Third Party Site to authenticate to or connect with your VisiKard account, that application or website can access information on VisiKard related to you and your connections.     </p>     </li>     <li>     <h3>13. Disclosure of User Information.</h3>     <p>     You acknowledge, consent and agree that we may access, preserve, and disclose your registration and any other information you provide if required to do so by law or in a good faith belief that such access preservation or disclosure is reasonably necessary in our opinion to: (1) comply with legal process, including, but not limited to, civil and criminal subpoenas, court orders or other compulsory disclosures; (2) enforce this Agreement; (3) respond to claims of a violation of the rights of third parties, whether or not the third party is a User, individual, or government agency; (4) respond to customer service inquiries; or (5) protect the rights, property, or personalsafety of VisiKard, our Users or the public.     </p>     </li>     <li>     <h3>14. Konnect, Trades, Interactions with Others</h3>     <p>     You are solely responsible for your interactions with other Users. VisiKard may limit the number of connections you may have to other Users and may, in certain circumstances, prohibit you from contacting other Users through use of the Services or otherwise limit your use of the Services. VisiKard reserves the right, but has no obligation, to monitor disputes between you and other members and to restrict, suspend, delete or close your account if VisiKard determines, in our sole discretion, that doing so is necessary to enforce this Agreement.     </p>     </li>     <li>     <h3>15. DISCLAIMER.</h3>     <p>     SOME COUNTRIES AND JURISDICTIONS DO NOT ALLOW THE DISCLAIMER OF IMPLIED TERMS IN CONTRACTS WITH CONSUMERS AND AS A RESULT THE CONTENTS OF THIS SECTION MAY NOT APPLY TO YOU.     </p>     <p>     DO NOT RELY ON VISIKARD, ANY INFORMATION THEREIN, OR ITS CONTINUATION. WE PROVIDE THE PLATFORM FOR VISIKARD AND ALL INFORMATION AND SERVICES ON AN “AS IS” AND “AS AVAILABLE” BASIS. VISIKARD DOES NOT CONTROL OR VET USER GENERATED CONTENT FOR ACCURACY. WE DO NOT PROVIDE ANY EXPRESS WARRANTIES OR REPRESENTATIONS.     </p>     <p>     TO THE FULLEST EXTENT PERMISSIBLE UNDER APPLICABLE LAW, WE DISCLAIM ANY AND ALL IMPLIED WARRANTIES AND REPRESENTATIONS, INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, ACCURACY OF DATA, AND NONINFRINGEMENT. IF YOU ARE DISSATISFIED OR HARMED BY VISIKARD OR ANYTHING RELATED TO VISIKARD, YOU MAY CLOSE YOUR VISIKARD ACCOUNT AND TERMINATE THIS AGREEMENT IN ACCORDANCE WITH SECTION 7 (“TERMINATION”) AND SUCH TERMINATION SHALL BE YOUR SOLE AND EXCLUSIVE REMEDY.     </p>     <p>     VISIKARD IS NOT RESPONSIBLE, AND MAKES NO REPRESENTATIONS OR WARRANTIES FOR THE DELIVERY OF ANY MESSAGES SENT THROUGH VISIKARD TO ANYONE. IN ADDITION, WE NEITHER WARRANT NOR REPRESENT THAT YOUR USE OF THE SERVICE WILL NOT INFRINGE THE RIGHTS OF THIRD PARTIES. ANY MATERIAL, SERVICE, OR TECHNOLOGY DESCRIBED OR USED ON THE WEBSITE MAY BE SUBJECT TO INTELLECTUAL PROPERTY RIGHTS OWNED BY THIRD PARTIES WHO HAVE LICENSED SUCH MATERIAL, SERVICE, OR TECHNOLOGY TO US.     </p>     <p>     VISIKARD DOES NOT HAVE ANY OBLIGATION TO VERIFY THE IDENTITY OF THE PERSONS SUBSCRIBING TO ITS SERVICES, NOR DOES IT HAVE ANY OBLIGATION TO MONITOR THE USE OF ITS SERVICES BY OTHER USERS OF THE COMMUNITY; THEREFORE, VISIKARD DISCLAIMS ALL LIABILITY FOR IDENTITY THEFT OR ANY OTHER MISUSE OF YOUR IDENTITY OR INFORMATION.     </p>     <p>     VISIKARD DOES NOT GUARANTEE THAT THE SERVICES IT PROVIDES WILL FUNCTION WITHOUT INTERRUPTION OR ERRORS IN FUNCTIONING. IN PARTICULAR, THE OPERATION OF THE SERVICES MAY BE INTERRUPTED DUE TO MAINTENANCE, UPDATES, OR SYSTEM OR NETWORK FAILURES. VISIKARD DISCLAIMS ALL LIABILITY FOR DAMAGES CAUSED BY ANY SUCH INTERRUPTION OR ERRORS IN FUNCTIONING. FURTHERMORE, VISIKARD DISCLAIMS ALL LIABILITY FOR ANY MALFUNCTIONING, IMPOSSIBILITY OF ACCESS, OR POOR USE CONDITIONS OF THE VISIKARD SITE DUE TO INAPPROPRIATE EQUIPMENT, DISTURBANCES RELATED TO INTERNET SERVICE PROVIDERS, TO THE SATURATION OF THE INTERNET NETWORK, AND FOR ANY OTHER REASON.     </p>       </li>     <li>     <h3>16. TERMINATION.</h3>     <p>     You may terminate this Agreement, for any or no reason, at any time, by deleting your account and responding “yes” to confirm such action.     </p>     <p>     VisiKard may terminate the Agreement and your account for any reason or no reason, at any time, with or without notice. This cancellation shall be effective immediately by electronic notification that your account will be deleted.     </p>     <p>     VisiKard may restrict, suspend or terminate the account of any User who abuses or misuses the Services. Misuse of the Services includes abusing the VisiKard messaging services; creating false profiles; infringing any intellectual property rights, violating any of the Do’s and Don’ts listed in Section 20, or any other behavior that VisiKard, in its sole discretion, deems contrary to its purpose.     </p>          </li>     <li>     <h3>17. DISPUTE RESOLUTION</h3>     <p>This Agreement or any claim, cause of action or dispute (“claim”) arising out of or related to this Agreement shall be governed by the laws of the state of Georgia regardless of your country of origin or where you access VisiKard, and notwithstanding of any conflicts of law principles. You and VisiKard agree that all claims arising out of or related to this Agreement must be resolved exclusively by a state or federal court located in Cobb County, Georgia except as otherwise agreed by the parties or as described in the Arbitration Option paragraph below. You and VisiKard agree to submit to the personal jurisdiction of the courts located within Cobb County, Georgia for the purpose of litigating all such claims. Notwithstanding the above, you agree that VisiKard shall still be allowed to apply for injunctive remedies (or an equivalent type of urgent legal relief) in any jurisdiction. </p>     </li>     <li>     <h3>18. ARBITRATION</h3>     <p>     For any claim (excluding claims for injunctive or other equitable relief) where the total amount of the award sought is less than $10,000, the party requesting relief may elect to resolve the dispute in a cost effective manner through binding non-appearance-based arbitration. In the event a party elects arbitration, they shall initiate such arbitration through an established alternative dispute resolution (“ADR”) provider mutually agreed upon by the parties. The ADR provider and the parties must comply with the following rules: (a) the arbitration shall be conducted by telephone, online and/or be solely based on written submissions, the specific manner shall be chosen by the party initiating the arbitration; (b) the arbitration shall not involve any personal appearance by the parties or witnesses unless otherwise mutually agreed by the parties; and (c) any judgment on the award rendered by the arbitrator shall be final and may be entered in any court of competent jurisdiction.     </p>     </li>     <li>     <h3>19. For legal notices you may contact us at:</h3>     <p>     <b>VisiKard, Inc.</b> <br>                                     ATTN: Legal <br>     2839 aces Ferry Road, Suite 1100<br>     Atlanta, GA 30339 <br>     USA <br>          </p>     </li>     <li>     <h3> 20. Entire Agreement.</h3>     <p>     You agree that this Agreement constitutes the entire, complete and exclusive agreement between you and VisiKard regarding its application and services and supersedes all prior agreements and understandings, whether written or oral, or whether established by custom, practice, policy or precedent, with respect to the subject matter of this Agreement. You also acknowledge that you may be subject to additional terms and conditions that may apply when you use third-party content or third party software.     </p>     </li>     <li>     <h3>21. Amendments </h3>     <p>     We reserve the right to modify, supplement or replace the terms of the Agreement, effective upon electronic communication, via our mobile application or by posting at www.VisiKard.com or notifying you otherwise.     </p>     <p>     No informal waivers, agreements or representations. Our failure to act with respect to a breach of this Agreement by you or others does not waive our right to act with respect to that breach or subsequent similar or other breaches. Except as expressly and specifically contemplated by the Agreement, no representations, statements, consents, waivers or other acts or omissions by any VisiKard Affiliate shall be deemed legally binding on any VisiKard Affiliate, unless documented in a physical writing hand signed by a duly appointed officer of VisiKard.     </p>     <p>     No Injunctive Relief.  In no event shall you seek or be entitled to rescission, injunctive or other equitable relief, or to enjoin or restrain the operation of the Service, exploitation of any advertising or other materials issued in connection therewith, or exploitation of the Services or any content or other material used or displayed through the Services.     </p>     </li>     <li>     <h3>22. VISIKARD USER “DOS” and “DON’TS.”</h3>     <p>     As a condition to access VisiKard, you agree to this Agreement and to strictly adhere to the following     </p>     <h4> DO:</h4>     <ul class=\"circle-buidlet\">     <li>•	Comply with all applicable laws, including, without limitation, privacy laws, intellectual property laws, export control laws, tax laws, and regulatory requirements;</li>     <li>•	Be cautious when providing your information to others (Kards, Konnect, Trade)</li>     <li>•	Protect your sensitive personal information</li>     <li>•	Provide accurate information to us and update it as necessary;</li>     <li>•	Review and comply with our Privacy Policy;</li>     <li>•	Review and comply with notices sent by VisiKard concerning the Services; and</li>     <li>•	Use the Services in a polite and professional manner.</li>     </ul>     <h4>DON’T:</h4>     <ul class=\"circle-buidlet\">     <li>•	Act dishonestly or unprofessionally by engaging in unprofessional behavior by posting inappropriate, inaccurate, or objectionable content to VisiKard;</li>     <li>•	Publish inaccurate information in the designated fields on the profile form </li>     <li>•	Create a false identity on VisiKard;</li>     <li>•	Falsely state, impersonate or otherwise misrepresents your identity</li>     <li>•	Use language or upload photos that are unlawful, libelous, abusive, obscene, discriminatory or otherwise objectionable;</li>     <li>•	Include information that you do not have the right to disclose or make available under any law or under contractual or fiduciary relationships</li>     <li>•	Infringe upon patents, trademarks, trade secrets, copyrights or other proprietary rights;</li>     <li>•	Duplicate, license, sublicense, publish, broadcast, transmit, distribute, perform, display, sell, rebrand, or otherwise transfer information found on VisiKard (excluding content posted by you) except as permitted in this Agreement, VisiKard’s developer terms and policies, or as expressly authorized by VisiKard;</li>     <li>•	Reverse engineer, decompile, disassemble, decipher or otherwise attempt to derive the source code for any underlying intellectual property used to provide the Services, or any part thereof</li>     <li>•	Utilize or copy information, content or any data you view on and/or obtain from VisiKard to provide any service that is competitive, in VisiKard’s sole discretion, with VisiKard;</li>     <li>•	Adapt, modify or create derivative works based on VisiKard or technology underlying the Services, or other Users’ content, in whole or part, except as permitted under VisiKard’s developer program;</li>     <li>•	Infringe or use VisiKard’s brand, logos and/or trademarks, including, without limitation, using the word “VisiKard” in any business name, email, or URL or including VisiKard’s trademarks and logos except as provided in the Brand Guidelines or as expressly permitted by VisiKard</li>     </ul>     </li>          </ul>     </div> </body></html>" baseURL:nil];
    
    // add to view
    [self.view addSubview:self.termsView];
    CGRect rect = CGRectMake(0, HEIGHT_IPHONE, WIDTH_IPHONE, HEIGHT_IPHONE - HEIGHT_STATUS_BAR);
    self.termsView.frame = rect;
    rect.origin.y = 0;
    [UIView animateWithDuration:0.3f animations:^{
        self.termsView.frame = rect;
    }];
}

- (IBAction)saveTouchUpInside:(UIButton *)sender {
    if ([self checkForErrorValidation:ENUM_FIELD_CHECK_FIELD_EMPTY]) {
        if ([self checkForErrorValidation:ENUM_FIELD_CHECK_EMAIL]) {
            if ([self checkForErrorValidation:ENUM_FIELD_CHECK_PASSWORK]) {
                [self requestDataWithType:ENUM_API_REQUEST_TYPE_USER_REGISTER];
            }
        }
    }
}

- (IBAction)facebookBtnTouchUpInside:(UIButton *)sender {
    [self dismissAllKeyboard];
    BOOL state = sender.selected;
    _facebookBtn.selected = NO;
    _twitterBtn.selected = NO;
    if(state)
    {
        sender.selected = !state;
        return;
    }

    if (![ASIHTTPRequest isNetworkReachable]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_CONNECTION_ERROR);
        return;
    }
    
    [[AppViewController Shared] changeToFacebookViewController];
}

- (IBAction)twitterBtnTouchUpInside:(UIButton *)sender {
    [self dismissAllKeyboard];
    BOOL state = sender.selected;
    _facebookBtn.selected = NO;
    _twitterBtn.selected = NO;
    if(state)
    {
        sender.selected = !state;
        return;
    }
    
    if (![ASIHTTPRequest isNetworkReachable]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_CONNECTION_ERROR);
        return;
    }
    
    [[AppViewController Shared] changeToTwitterViewController];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // MinhPB 2012/11/20
//    self.emailTextField == textField ? [self.passwordTextField resignFirstResponder] : [self.emailTextField resignFirstResponder];
//
//    NSLog(@"textFieldShouldBeginEditing 111 %@", textField);
//    textField.textAlignment = NSTextAlignmentLeft;
//    textField.placeholder = @"";
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    // MinhPB 2012/11/20
//    NSLog(@"textFieldShouldReturn 222 %@", textField);
//    [textField resignFirstResponder];
    if (textField == emailTextField) {
        [passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    // MinhPB 2012/11/20
//    NSLog(@"textFieldShouldEndEditing 333 %@", textField);
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    // MinhPB 2012/11/20
//    NSLog(@"textFieldDidEndEditing 444 %@", textField);
//    emailTextField.placeholder = REGISTER_EMAIL_PLACEHOLDER_STR;
//    passwordTextField.placeholder = REGISTER_PASSWORD_PLACEHOLDER_STR;
//    
//    if([textField.text isEqualToString:@""])
//        textField.textAlignment = NSTextAlignmentCenter;
    
    // validate info
    [self validateInfo];
}

#pragma mark - Utility functions
-(void)resetAgeView
{
    if(!self.ageBtn.selected)
        return;
    self.ageBtn.selected = NO;
    
    NSString *imgName = @"welcome_field.png";
    UIImage *img = [UIImage imageNamed:imgName];
    CGSize expandSize = img.size;
    [self.ageViewBackground setImage:img];
    // resize age view
    CGRect rect = self.ageView.frame;
    rect.size = expandSize;
    
    CGFloat delta = REGISTER_EXPANDED_FIELD_HEIGH - REGISTER_FIELD_HEIGH;
    CGRect genderRect = self.genderView.frame;
    genderRect.origin.y -= delta;
    
//    CGRect saveBtnRect = self.saveBtn.frame;
//    BOOL isIphone5 = NO;
//    if (!isIphone5) {
//        saveBtnRect.origin.y -= REGISTER_SAVEBTN_DETAL_Y;
//    }
    
    self.ageView.frame = rect;
    self.genderView.frame = genderRect;
//    self.saveBtn.frame = saveBtnRect;
    self.ageSelectorView.hidden = YES;
}

-(void)resetGenderView
{
    if(!self.genderBtn.selected)
        return;
    self.genderBtn.selected = NO;
    
    NSString *imgName = @"welcome_field.png";
    UIImage *img = [UIImage imageNamed:imgName];
    CGSize expandSize = img.size;
    [self.genderViewBackground setImage:img];
    // resize age view
    CGRect rect = self.genderView.frame;
    rect.size = expandSize;
    
//    CGRect saveBtnRect = self.saveBtn.frame;
//    BOOL isIphone5 = NO;
//    if (!isIphone5) {
//        saveBtnRect.origin.y -= REGISTER_SAVEBTN_DETAL_Y;
//    }
    
    self.genderView.frame = rect;
//    self.saveBtn.frame = saveBtnRect;
    self.genderSelectorView.hidden = YES;
}

-(void)validateInfo {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    BOOL isValid = ![email isEqualToString:@""] && ![password isEqualToString:@""] && _age != enum_age_count && _gender != enum_gender_count;
    self.saveBtn.enabled = isValid;
}

- (void)viewDidUnload {
    [self setTermsView:nil];
    [self setTermConditionWebView:nil];
    [self setContainerView:nil];
    [self setUserNameTemp:nil];
    [self setPassTemp:nil];
    [super viewDidUnload];
}

- (BOOL)checkForErrorValidation:(ENUM_FIELD_CHECK)typeCheck
{
    switch (typeCheck) {
        case ENUM_FIELD_CHECK_EMAIL:
        {
            if ([self isValidFieldRegisterWithCheck:ENUM_FIELD_CHECK_EMAIL]) {
                return YES;
            }else {
                [self alertView:STRING_ALERT_TITLE_SORRY withMessage:kAlertEmailErrorFormat withDismissButton:STRING_ALERT_OK];
            }
        }
            break;
        case ENUM_FIELD_CHECK_PASSWORK:
        {
            if (self.passwordTextField.text.length >= kLeastPassword &&self.passwordTextField.text.length < kTooLongPassword ) {
                return YES;
            }else {
                [self alertView:STRING_ALERT_TITLE_SORRY withMessage:kAlertPasswordFormat withDismissButton:STRING_ALERT_OK];
                [self.passwordTextField becomeFirstResponder];
            }
        }
            break;
        case ENUM_FIELD_CHECK_FIELD_EMPTY:
            if ([self.emailTextField.text isEqualToString:STRING_EMPTY]  || [self.passwordTextField.text isEqualToString:STRING_EMPTY] || self.age == enum_age_count || self.gender == enum_gender_count) {
                [self alertView:STRING_ALERT_TITLE_SORRY withMessage:kAlertEmptyField withDismissButton:STRING_ALERT_OK];
            }else {
                return YES;
            }
            
            break;
        default:
            break;
    }
    
    return NO;
}

- (BOOL)isValidFieldRegisterWithCheck:(ENUM_FIELD_CHECK)typeCheck
{
    switch (typeCheck) {
        case ENUM_FIELD_CHECK_EMAIL:
        {
            self.emailTextField.text = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            return [emailTest evaluateWithObject:self.emailTextField.text];
        }
            break;
        case ENUM_FIELD_CHECK_PASSWORK:
        {
            if (self.passwordTextField.text.length > 5 &&self.passwordTextField.text.length < 21 ) {
                return YES;
            }
            
        }
            break;
        case ENUM_FIELD_CHECK_FIELD_EMPTY:
            if (![self.emailTextField.text isEqualToString:STRING_EMPTY]  && ![self.passwordTextField.text isEqualToString:STRING_EMPTY]) {
                return  YES;
            }
            break;
        default:
            break;
    }
    
    return NO;
}

- (void)alertView:(NSString *)title withMessage:(NSString *)message withDismissButton:(NSString *)dismissString{
    UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:dismissString otherButtonTitles:nil];
    [_alert show];
}

-(void)updateInfoFromFacebook:(NSDictionary *)params
{
    // dismiss all keyboard and collape age, gender selector
    [self dismissAllKeyboard];
    [self ageBtnTouchUpInside:self.ageBtn];
    [self genderBtnTouchUpInside:self.genderBtn];
    
    self.emailTextField.text = [params valueForKey:STRING_REQUEST_KEY_EMAIL];
    self.facebookBtn.selected = YES;
    
    // set age
    NSInteger age = [[params valueForKey:STRING_REQUEST_KEY_AGE] integerValue];
    if(age != -1)
    {
        if(age >= 10 && age <= 14)
        {
            self.age = enum_age_10_14;
        }
        else if (age >= 15 && age <= 19)
        {
            self.age = enum_age_15_19;
        }
        else if (age >= 20 && age <= 30)
        {
            self.age = enum_age_20_30;
        }
        else if (age >= 31 && age <= 44)
        {
            self.age = enum_age_31_44;
        }
        else if (age >= 45 && age <= 54)
        {
            self.age = enum_age_45_54;
        }
        else if (age >= 55 && age <= 64)
        {
            self.age = enum_age_55_64;
        }
        else
        {
            self.age = enum_age_over_65;
        }
        
        UIButton *ageBtn = (UIButton *)[self.view viewWithTag:self.age];
        ageBtn.selected = NO;
        [self ageSelectorTouchUpInside:ageBtn];
    }
    // set gender
    NSString *gStr = [params valueForKey:STRING_REQUEST_KEY_GENDER];

    if(![gStr isEqualToString:@""])
    {
        self.gender = [gStr isEqualToString:@"female"] ? enum_gender_female : enum_gender_count;
        self.gender = [gStr isEqualToString:@"male"] ? enum_gender_male : enum_gender_count;
        if(self.gender != enum_gender_count)
        {
            UIButton *genderBtn = (UIButton *)[self.view viewWithTag:self.gender];
            genderBtn.selected = NO;
            [self genderSelectorTouchUpInside:genderBtn];
        }
    }
    
    // set name
    self.firstName = [params valueForKey:STRING_REQUEST_KEY_F_NAME];
    self.lastName = [params valueForKey:STRING_REQUEST_KEY_L_NAME];
}

-(void)updateInfoFromTwitter:(NSDictionary *)params
{
    // dismiss all keyboard and collape age, gender selector
    [self dismissAllKeyboard];
    [self ageBtnTouchUpInside:self.ageBtn];
    [self genderBtnTouchUpInside:self.genderBtn];
    
    self.twitterBtn.selected = YES;
    
    self.firstName = [params valueForKey:STRING_REQUEST_KEY_F_NAME];
    self.lastName = [params valueForKey:STRING_REQUEST_KEY_L_NAME];
    NSString *gStr = [params valueForKey:STRING_REQUEST_KEY_GENDER];
    if(![gStr isEqualToString:@""])
    {
        self.gender = [gStr isEqualToString:@"female"] ? enum_gender_female : enum_gender_count;
        self.gender = [gStr isEqualToString:@"male"] ? enum_gender_male : enum_gender_count;
        if(self.gender != enum_gender_count)
        {
            UIButton *genderBtn = (UIButton *)[self.view viewWithTag:self.gender];
            genderBtn.selected = NO;
            [self genderSelectorTouchUpInside:genderBtn];
        }
    }
}

-(void)dismissAllKeyboard {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark -UIGestureRecognizerDelegate
-(void)dismissKeyBoard:(UITapGestureRecognizer*)recognizer
{
    [self dismissAllKeyboard];
}

#pragma mark - API Request
- (void)requestDataWithType:(ENUM_API_REQUEST_TYPE)type
{
    if (type == ENUM_API_REQUEST_TYPE_USER_REGISTER) {
        // tait: TODO register screen
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"", @"", self.emailTextField.text, self.passwordTextField.text, [NSNumber numberWithInt:(self.age - enum_age_10_14)], [NSNumber numberWithInt:(self.gender - enum_gender_female)], nil] forKeys:[NSArray arrayWithObjects:@"fname", @"lname", @"email", @"password", @"age", @"gender", nil]];
        [requester requestWithType:type andRootURL:STRING_REQUEST_URL_REGISTRY_ACCOUNT andPostMethodKind:YES andParams:userInfo andDelegate:self];
    }
    if (type == ENUM_API_REQUEST_TYPE_USER_RECOVER_PASSWORD) {
        NSMutableDictionary *_param = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.emailTextField.text,@"email", nil];
        [requester requestWithType:type andRootURL:STRING_REQUEST_URL_USER_RECOVERY_PASSWORD andPostMethodKind:YES andParams:_param andDelegate:self];
    }
    [[AppViewController Shared] isRequesting:YES andRequestType:type andFrame:FRAME(0, 0, WIDTH_IPHONE, HEIGHT_IPHONE)];
}

- (void)requestFailed:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type
{
//    NSLog(@" requestFailed %@ ", request.responseString);
    
    [[AppViewController Shared] isRequesting:NO andRequestType:ENUM_API_REQUEST_TYPE_INVALID andFrame:CGRectZero];
    
    ALERT(STRING_ALERT_TITLE_SORRY, STRING_ALERT_CONNECTION_ERROR);
}

- (void)requestFinished:(ASIHTTPRequest *)request andType:(ENUM_API_REQUEST_TYPE)type
{
//    NSLog(@" requestFinished %@ ", request.responseString);
    
    [[AppViewController Shared] isRequesting:NO andRequestType:ENUM_API_REQUEST_TYPE_INVALID andFrame:CGRectZero];
    
    NSError *error;
    SBJSON *sbJSON = [SBJSON new];
    
    if (![sbJSON objectWithString:[request responseString] error:&error] || request.responseStatusCode != 200 || !request) {
        //        if (![ASIHTTPRequest isNetworkReachable]) {
        //            ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
        //        }
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
        return;
    }
    NSArray *jsonArray = [sbJSON objectWithString:[request responseString] error:&error];
    if ([jsonArray count] > 0) {
        if (type == ENUM_API_REQUEST_TYPE_USER_REGISTER) {
            NSMutableDictionary *registerDict =  [SupportFunction repairingDictionaryWith:[jsonArray objectAtIndex:0]];
            NSString *message = [registerDict objectForKey:@"messageLogin"];
            if([message isEqualToString:@"FAILURE"]) {
                [self alertView:STRING_ALERT_TITLE_SORRY  withMessage:[NSString stringWithFormat:STRING_ALERT_REGISTRATION_UNSUCCESS] withDismissButton:STRING_ALERT_OK];
            }
            else if ([message isEqualToString:@"EXIST USERNAME"]) {
                [self alertView:STRING_ALERT_TITLE_SORRY withMessage:STRING_ALERT_REGISTRATION_USER_NAME_ALREADY withDismissButton:STRING_ALERT_OK];
            }
            else if ([message isEqualToString:@"EXIST EMAIL"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:STRING_ALERT_TITLE_SORRY message:STRING_ALERT_REGISTRATION_EMAIL_ALREADY delegate:self cancelButtonTitle:STRING_ALERT_OK otherButtonTitles:STRING_ALERT_NO, nil];
                [alert setTag:enumTagEmailAlert];
                [alert show];
            }
            else {
                // , sessionID, loginStatus, isLoginWith_FB_TW, avatarSmallURL, fullName, loginAtTheFirstTime
                [[AppViewController Shared] isRequesting:NO andRequestType:ENUM_API_REQUEST_TYPE_INVALID andFrame:FRAME(0, 0, WIDTH_IPHONE, HEIGHT_IPHONE)];
                [[UserDataManager Shared] resetAllData];// MinhPB 2012/07/09
                
                [UserDataManager Shared].userID =  [[registerDict objectForKey:STRING_RESPONSE_KEY_USER_ID] intValue];
                [UserDataManager Shared].userName = [registerDict objectForKey:STRING_RESPONSE_KEY_USER_NAME];
                [UserDataManager Shared].accessToken = @"";
                [UserDataManager Shared].password = self.passwordTextField.text;
                [UserDataManager Shared].sessionID = [registerDict objectForKey:STRING_RESPONSE_KEY_SESSION_ID];
                [UserDataManager Shared].isLoginWith_FB_TW = NO;
                [UserDataManager Shared].avatarSmallURL = @"";
                [UserDataManager Shared].loginStatus = YES;
                [UserDataManager Shared].loginAtTheFirstTime = YES;
                [[UserDataManager Shared] save];
                //                registerAlert  = [[UIAlertView alloc] initWithTitle:STRING_ALERT_TITLE_SUCCESS message:@"Your accout has been created sucessfully.You must create a Kard to enjoy App. Please press OK to create your Kard now! " delegate:self cancelButtonTitle:STRING_ALERT_OK otherButtonTitles:nil, nil];
                //                [registerAlert show];
                //                [registerAlert release];
                
                [[AppViewController Shared] changeToHomeFromWelcomeScreen:YES];
            }
        }
        if (type ==  ENUM_API_REQUEST_TYPE_USER_RECOVER_PASSWORD) {
            NSDictionary *_dict = [jsonArray objectAtIndex:0];
            if ([[_dict objectForKey:STRING_RESPONSE_KEY_MESSAGE] isEqualToString:STRING_RESPONSE_CODE_SUCCESS]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:STRING_ALERT_RECOVERY_PASSWORD_SUCCESS delegate:nil cancelButtonTitle:STRING_ALERT_OK otherButtonTitles:nil, nil];
                [alert show];
            }
            else
                ALERT(STRING_ALERT_TITLE_SORRY, STRING_ALERT_RECOVERY_PASSWORD_EMAIL_INVALID);
        }
    }
    else {
        //        if (![ASIHTTPRequest isNetworkReachable]) {
        //            ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
        //        }
        ALERT(STRING_ALERT_CONNECTION_ERROR_TITLE, STRING_ALERT_SERVER_ERROR);
    }
    
}

@end
