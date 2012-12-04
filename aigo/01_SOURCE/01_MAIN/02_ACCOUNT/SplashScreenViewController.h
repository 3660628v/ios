//
//  SplashScreenViewController.h
//  VISIKARD
//
//  Created by Huu Vinh Huynh on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutomationDataManager.h"

@interface SplashScreenViewController : UIViewController <AutomationDataManagerProtocol> {
    APIRequester                    *_APIRequester;
}
@property (retain, nonatomic) IBOutlet UIImageView *imageViewLoading;

@end
