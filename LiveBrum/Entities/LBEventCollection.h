//
//  LBEventCollection.h
//  LiveBrum
//
//  Created by Max Woolf on 29/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  Used to generate a collection of LBEvents using one of a number of searches (Date, venue etc...)
//

#import <Foundation/Foundation.h>
#import "LBEvent.h"

@class LBEventCollection;
@protocol LBEventCollectionDelegate <NSObject>

-(void)dataDidFinishLoading;

@end

@interface LBEventCollection : NSObject <NSURLConnectionDataDelegate>
{
    NSMutableArray *events;
    NSMutableData *receivedData;
    NSDictionary *root;
    id <LBEventCollectionDelegate> delegate;
}

-(id)initWithDate:(NSString *)aDate month:(NSString *)aMonth year:(NSString *)aYear;
-(id)withTodaysEvents;
-(int)numberOfEventsInCollection;
-(void)convertToEvents;


@property (nonatomic) NSArray *events;
@property(nonatomic) id delegate;
@end
