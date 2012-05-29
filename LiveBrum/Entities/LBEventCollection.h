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
    NSArray *events;
    NSMutableData *receivedData;
    id <LBEventCollectionDelegate> delegate;
}

-(id)initWithDate:(NSInteger *)aDate month:(NSInteger *)aMonth year:(NSInteger *)aYear;

@property (nonatomic) NSArray *events;
@property(nonatomic,assign) id delegate;
@end
