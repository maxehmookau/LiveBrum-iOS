//
//  LBGeocoder.h
//  LiveBrum
//
//  Created by Max Woolf on 05/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LBGeocoder;

@protocol LBGeocoderDelegate <NSObject>

-(void)geocoder:(LBGeocoder *)geocoder didSuccessfullyResolvePostcode:(NSString *)postcode;
@optional
-(void)geocoderFailedToResolvePostcodeWithError:(NSError *)error;

@end
@interface LBGeocoder : NSObject <NSURLConnectionDataDelegate>
{
    float latitude;
    float longitude;
    NSString *postcode;
    NSURLConnection *connection;
    NSURLRequest *request;
    id <LBGeocoderDelegate> delegate;
    NSMutableData *receivedData;
}

-(id)initWithLongitude:(float)aLongitude latitude:(float)aLatitude;
-(void)findPostcode;

@property (nonatomic) NSString *postcode;
@property (nonatomic) id delegate;

@end
