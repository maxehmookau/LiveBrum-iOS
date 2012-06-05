//
//  LBGeocoder.m
//  LiveBrum
//
//  Created by Max Woolf on 05/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBGeocoder.h"


@implementation LBGeocoder
@synthesize postcode, delegate;

-(id)initWithLongitude:(float)aLongitude latitude:(float)aLatitude
{
    longitude = aLongitude;
    latitude = aLatitude;
    request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true", latitude, longitude]]];
    NSLog(@"%@", [[request URL]absoluteString]);
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    receivedData = [[NSMutableData alloc] init];
    return [super init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self findPostcode];
    [delegate geocoder:self didSuccessfullyResolvePostcode:postcode];
}

-(void)findPostcode
{
    NSError *error = nil;
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableLeaves error:&error];
    if(error)
    {
        [delegate geocoderFailedToResolvePostcodeWithError:error];
    }
    NSArray *components = [root objectForKey:@"results"];
    for (NSDictionary* component in components)
    {
        //Find result with postcode
        if([[[component objectForKey:@"types"]objectAtIndex:0]isEqualToString:@"postal_code"])
        {
            postcode = [[[component objectForKey:@"address_components"]objectAtIndex:0]valueForKey:@"long_name"];
        }
    }
}
@end
