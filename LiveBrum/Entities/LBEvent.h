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
    NSString *dateRange;
    NSString *genre;
    UIImage *image;
    NSString *desc;
    NSString *venue;
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
@property (nonatomic) NSString *dateRange;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *genre;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *venue; //This is only temporary
@property (nonatomic) id delegate;

@end
