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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

@end
