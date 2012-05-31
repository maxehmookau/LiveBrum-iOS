#import "LBVenue.h"
#import "LBAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation LBVenue
@synthesize name, description, location, distanceFromUser, delegate, distanceString, mapView;

-(id)initWithName:(NSString *)aName description:(NSString *)aDescription
{
    name = aName;
    description = aDescription;
    
    //Hard coded with somewhere in devon for now... we'll fix it later.
    location = [[CLLocation alloc] initWithLatitude:52.4240325 longitude:-1.9291173999999955];
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
    [locationManager setDistanceFilter:20];
    distanceFromUser = [location distanceFromLocation:userLocation];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 300, 199)];
    [mapView setMapType:MKMapTypeStandard];
    [mapView.layer setCornerRadius:10];
    [mapView.layer setMasksToBounds:YES];
 
    [mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(52.4240325, -1.9291173999999955), MKCoordinateSpanMake(0.001, 0.006))animated:YES];
    
    return [super init];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    userLocation = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.longitude longitude:newLocation.coordinate.latitude];
    
    distanceFromUser = [location distanceFromLocation:newLocation] * 0.00062137119;
    
    //If we're close, convert to meters.
    if(distanceFromUser < 1.0)
    {
        int nLocation = (int)[location distanceFromLocation:newLocation];
        distanceString = [NSString stringWithFormat:@"%i m", nLocation]; 
    }else{
        int nLocation = (int)[location distanceFromLocation:newLocation] * 0.00062137119;
        distanceString = [NSString stringWithFormat:@"%i mi", nLocation];
    }
    
    
    //NSLog(@"%@", distanceString);
    //Alert the delegate that the user has moved in relation to the venue
    [delegate userMoved];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    distanceString = @"?";
    [delegate userMoved];
}
                        
@end
