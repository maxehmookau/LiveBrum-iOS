//
//  LBPerformance.h
//  LiveBrum
//
//  Created by Max Woolf on 30/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBPerformance : NSObject
{
    NSDate *date;
}

-(id)initWithDate:(NSString *)aDate;
-(NSString *)time;

@property (nonatomic) NSDate *date;
@end
