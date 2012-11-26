//
//  DriverMainViewController.m
//  aigo
//
//  Created by Tai Truong on 11/26/12.
//  Copyright (c) 2012 AIGO. All rights reserved.
//

#import "DriverMainViewController.h"

@interface DriverMainViewController ()

@end

@implementation DriverMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:57.0f/255.0f green:59.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
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

@end
