//
//  WelcomeViewController.m
//  VISIKARD
//
//  Created by Phan Ba Minh on 11/15/12.
//
//

#import "WelcomeViewController.h"
#import "AppViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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

#pragma mark - Actions

- (IBAction)touchUpInsideRegister:(id)sender {
    [[AppViewController Shared] changeToRegister];
}

- (IBAction)touchUpInsideSignIn:(id)sender {
    [[AppViewController Shared] changeToLogin];
}

@end
