//
//  LBVenue.h
//  LiveBrum
//
//  Created by Max Woolf on 29/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@class LBVenue;

@protocol LBVenueDelegate <NSObject>

-(void)userMoved;

@end
@interface LBVenue : NSObject <CLLocationManagerDelegate>
{
    NSString *name;
    NSString *description;
    CLLocation *location;
    CLLocation *userLocation;
    CLLocationManager *locationManager;
    double distanceFromUser;
    NSString *distanceString;
    id <LBVenueDelegate> delegate;
    MKMapView *mapView;
}

-(id)initWithName:(NSString *)aName description:(NSString *)aDescription;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@property (nonatomic) CLLocation *location;
@property (nonatomic) id delegate;
@property (nonatomic) double distanceFromUser;
@property (nonatomic) NSString *distanceString;
@property (nonatomic) MKMapView *mapView;
@end
