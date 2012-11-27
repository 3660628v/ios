//
//  DriverMainViewController.m
//  aigo
//
//  Created by Tai Truong on 11/26/12.
//  Copyright (c) 2012 AIGO. All rights reserved.
//

#import "DriverMainViewController.h"

@interface DriverMainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ivRatingStar1;
@property (strong, nonatomic) IBOutlet UIView *ivRatingStar2;
@property (weak, nonatomic) IBOutlet UIImageView *ivRatingStar3;
@property (weak, nonatomic) IBOutlet UIImageView *ivRatingStar4;
@property (weak, nonatomic) IBOutlet UIImageView *ivRatingStar5;

- (IBAction)showPopupMenuTouchUpInside:(UIButton *)sender;
- (IBAction)notifyClientTouchUpInside:(UIButton *)sender;
- (IBAction)callClientTouchUpInside:(UIButton *)sender;
- (IBAction)cancelTransactionTouchUpInside:(UIButton *)sender;
@end

@implementation DriverMainViewController
{
    CLLocationManager *locationManager;
    CGFloat distance;
    CLLocation *currentLocation;
    NSMutableArray *path;
    MKPolyline *line;
}

@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:57.0f/255.0f green:59.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        distance = 0;
        path = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    // Do any additional setup after loading the view from its nib.
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLblRemainDistance:nil];
    [self setLblRemainMins:nil];
    [self setLbRemainSecs:nil];
    [self setLblName:nil];
    [self setLblRating:nil];
    [self setIvRatingStar1:nil];
    [self setIvRatingStar2:nil];
    [self setIvRatingStar3:nil];
    [self setIvRatingStar4:nil];
    [self setIvRatingStar5:nil];
    [self setLblAddress:nil];
    [self setBtnLocation:nil];
    [self setBtnLocationTouchUpInside:nil];
    [self setMapView:nil];
    [self setPopupMenuView:nil];
    [super viewDidUnload];
}
- (IBAction)showPopupMenuTouchUpInside:(UIButton *)sender {
    sender.selected = !sender.selected;
    CGRect menuRect = self.popupMenuView.frame;
    menuRect.origin.x = sender.selected ? (menuRect.origin.x - POPUP_MENU_WIDTH) : (menuRect.origin.x + POPUP_MENU_WIDTH);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve: UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4f];
    self.popupMenuView.frame = menuRect;
    [UIView commitAnimations];
}

- (IBAction)notifyClientTouchUpInside:(UIButton *)sender {
}

- (IBAction)callClientTouchUpInside:(UIButton *)sender {
}

- (IBAction)cancelTransactionTouchUpInside:(UIButton *)sender {
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (currentLocation != nil)
    {
        [path addObject:newLocation];
        if (line != nil)
        {
            [self.mapView removeOverlay:line];
        }
        CLLocationCoordinate2D *points = malloc(sizeof(CLLocationCoordinate2D) * [path count]);
        for (int i = 0; i < [path count]; i++)
        {
            points[i] = ((CLLocation *)[path objectAtIndex:i]).coordinate;
        }
        line = [MKPolyline polylineWithCoordinates:points count:[path count]];
        [self.mapView addOverlay:line];
        free(points);
    }
    else if (currentLocation == nil)
    {
        [self getAddressFromLocation:newLocation];
    }
    
    currentLocation = newLocation;
    [self plotTaxiPosition:newLocation.coordinate];
}

- (void)getAddressFromLocation:(CLLocation*)location {
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray * placemarks, NSError * error) {
        NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            //            [self displayError:error];
            return;
        }
        NSLog(@"Received placemarks: %@", placemarks);
        //        [self displayPlacemarks:placemarks];
        if ([placemarks count] > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSDictionary *dic = placemark.addressDictionary;
            NSLog(@"name %@", placemark.name);
            NSLog(@"locality %@", placemark.locality);
            NSLog(@"country %@", placemark.country);
            NSLog(@"administrativeArea %@", placemark.administrativeArea);
            NSLog(@"areasOfInterest %@", placemark.areasOfInterest);
            NSLog(@"inlandWater %@", placemark.inlandWater);
            NSLog(@"ISOcountryCode %@", placemark.ISOcountryCode);
            NSLog(@"ocean %@", placemark.ocean);
            NSLog(@"postalCode %@", placemark.postalCode);
            NSLog(@"thoroughfare %@", placemark.thoroughfare);
            NSLog(@"subThoroughfare %@", placemark.subThoroughfare);
            NSLog(@"subLocality %@", placemark.subLocality);
            NSLog(@"subAdministrativeArea %@", placemark.subAdministrativeArea);
            NSLog(@"addressDictionary %@", placemark.addressDictionary);
            
            // Add a More Info button to the annotation's view.
            NSString *addLine = [[dic valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
            [self.lblAddress setText:addLine];
        }
    } ];
}

-(void)plotTaxiPosition:(CLLocationCoordinate2D)userCoordinate
{
    for (id<MKAnnotation> annotation in self.mapView.annotations)
    {
        if ([annotation isKindOfClass:[AIGOMapPoint class]]) {
            [self.mapView removeAnnotation:annotation];
        }
    }
    
    CGPoint nePoint = CGPointMake(mapView.bounds.origin.x + mapView.bounds.size.width, mapView.bounds.origin.y);
    CGPoint swPoint = CGPointMake((mapView.bounds.origin.x), (mapView.bounds.origin.y + mapView.bounds.size.height));
    
    //Then transform those point into lat,lng values
    CLLocationCoordinate2D neCoord = [mapView convertPoint:nePoint toCoordinateFromView:mapView];
    CLLocationCoordinate2D swCoord = [mapView convertPoint:swPoint toCoordinateFromView:mapView];
    
    // Loop
    for (int i = 0; i < NUM_TAXI; i++) {
        double latRange = [self randomFloatBetween:neCoord.latitude andBig:swCoord.latitude];
        double longRange = [self randomFloatBetween:neCoord.longitude andBig:swCoord.longitude];
        
        // Add new waypoint to map
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latRange, longRange);
        NSString *taxiType = @"4 Seats";
        if(i >= NUM_TAXI_4SEATS)
            taxiType = @"7 Seats";
        
        AIGOMapPoint *mapPoint = [[AIGOMapPoint alloc] initWithName:taxiType address:@"" coordinate:location];
        [mapView addAnnotation:mapPoint];
        
    }
}

-(double)randomFloatBetween:(double)smallNumber andBig:(double)bigNumber {
    double diff = bigNumber - smallNumber;
    return (((double) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

#pragma mark - MKMapViewDelegate
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
{
    MKPolylineView *lineView = [[MKPolylineView alloc] initWithPolyline:line];
    lineView.fillColor = [UIColor redColor];
    lineView.strokeColor = [UIColor redColor];
    lineView.lineWidth = 3;
    
    return lineView;
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    static NSString *identifier;
//    if ([annotation isKindOfClass:[AIGOMapPoint class]]) {
//        UIImage *img;
//        if([((AIGOMapPoint*)annotation).name isEqualToString:@"7 Seats"])
//        {
//            identifier = @"7Seats";
//            img = [UIImage imageNamed:@"car2.png"];
//        } else {
//            identifier = @"4Seats";
//            img = [UIImage imageNamed:@"car.png"];
//        }
//        
//        MKPinAnnotationView *pinAnnotation = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//        if(pinAnnotation == nil)
//        {
//            pinAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//        }
//        else
//        {
//            pinAnnotation.annotation = annotation;
//        }
//        
//        pinAnnotation.enabled = YES;
//        pinAnnotation.canShowCallout = YES;
//        pinAnnotation.image = img;
//        return pinAnnotation;
//    }
//    
//    return nil;
//}

- (void)applicationWillResignActive
{
    if (YES)
    {
        [locationManager stopUpdatingLocation];
    }
}

- (void)applicationDidBecomeActive
{
    [locationManager startUpdatingLocation];
}
@end
