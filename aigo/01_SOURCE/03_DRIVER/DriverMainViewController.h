//
//  DriverMainViewController.h
//  aigo
//
//  Created by Tai Truong on 11/26/12.
//  Copyright (c) 2012 AIGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "AIGOMapPoint.h"

#define POPUP_MENU_WIDTH 117
#define METERS_PER_MILE 100
#define NUM_TAXI_7SEATS 3
#define NUM_TAXI_4SEATS 4
#define NUM_TAXI NUM_TAXI_7SEATS + NUM_TAXI_4SEATS

@interface DriverMainViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblRemainDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblRemainMins;
@property (weak, nonatomic) IBOutlet UILabel *lbRemainSecs;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *popupMenuView;

@property (weak, nonatomic) IBOutlet UIButton *btnLocationTouchUpInside;
@end
