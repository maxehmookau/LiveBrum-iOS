//
//  LBVenue.m
//  LiveBrum
//
//  Created by Max Woolf on 29/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBVenue.h"

@implementation LBVenue
@synthesize name, description;

-(id)initWithName:(NSString *)aName description:(NSString *)aDescription
{
    name = aName;
    description = aDescription;
    return [super init];
}
@end
