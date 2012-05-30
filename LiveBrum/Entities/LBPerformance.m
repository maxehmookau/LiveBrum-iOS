//
//  LBPerformance.m
//  LiveBrum
//
//  Created by Max Woolf on 30/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBPerformance.h"

@implementation LBPerformance
@synthesize date;
-(id)initWithDate:(NSString *)aDate
{
    date = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    date = [dateFormatter dateFromString:aDate];
    return [super init];
}

-(NSString *)time
{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"h:mma"];
    return [timeFormatter stringFromDate:date];
}
@end
