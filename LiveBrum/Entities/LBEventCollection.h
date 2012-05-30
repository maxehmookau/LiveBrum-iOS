//
//  LBEventCollection.h
//  LiveBrum
//
//  Created by Max Woolf on 29/05/2012.
//  Copyright (c) 2012 MaxWoolf. All rights reserved.
//  Used to generate a collection of LBEvents using one of a number of searches (Date, venue etc...)
//

#import <Foundation/Foundation.h>
#import "LBEvent.h"

@class LBEventCollection;
@protocol LBEventCollectionDelegate <NSObject>

-(void)collectionDidFinishLoading;
-(void)collectionFailedToLoadWithError:(NSError *)error;

@end

@interface LBEventCollection : NSObject <NSURLConnectionDataDelegate, LBEventProtocol>
{
    NSMutableArray *events;
    NSMutableData *receivedData;
    NSDictionary *root;
    id <LBEventCollectionDelegate> delegate;
    int completedEvents;
}

-(id)initWithDate:(NSString *)aDate month:(NSString *)aMonth year:(NSString *)aYear;
-(id)withTodaysEvents;
-(int)numberOfEventsInCollection;
-(void)convertToEvents;


@property (nonatomic) NSMutableArray *events;
@property(nonatomic) id delegate;
@end
