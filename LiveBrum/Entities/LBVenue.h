//
//  LBVenue.h
//  LiveBrum
//
//  Created by Max Woolf on 29/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LBVenue : NSObject
{
    NSString *name;
    NSString *description;
    CLLocationDistance *distance;
    CLLocation *location;
}

-(id)initWithName:(NSString *)aName description:(NSString *)aDescription;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@end
