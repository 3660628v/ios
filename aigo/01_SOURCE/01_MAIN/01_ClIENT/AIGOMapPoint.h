//
//  AIGOMapPoint.h
//  aigo
//
//  Created by Tai Truong on 11/20/12.
//  Copyright (c) 2012 AIGO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AIGOMapPoint : NSObject <MKAnnotation>
@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
