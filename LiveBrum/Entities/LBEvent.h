#import <Foundation/Foundation.h>
#import "LBVenue.h"
@class LBEvent;

@protocol LBEventProtocol <NSObject>

-(void)eventDidFinishLoading;

@end

@interface LBEvent : NSObject <NSURLConnectionDataDelegate>
{
    NSDictionary *rootDictionary;
    NSString *name;
    NSURL *source;
    UIImage *image;
    NSString *description;
    LBVenue *venue;
    id <LBEventProtocol> delegate;
    
    NSMutableData *receivedData;
}


/*
 * Initialiser
 * @param aURL - Pass a JSON file containing LB event data.
 */
-(id)initWithLiveBrumURL:(NSURL *)aURL;
-(void)parseReceivedData;

@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *source;
@property (nonatomic) NSString *description;
@property (nonatomic) UIImage *image;
@property (nonatomic) LBVenue *venue;
@property (nonatomic) id delegate;

@end
