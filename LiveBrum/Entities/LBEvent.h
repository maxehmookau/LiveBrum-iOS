#import <Foundation/Foundation.h>
#import "LBVenue.h"

@interface LBEvent : NSObject
{
    NSString *name;
    NSURL *source;
    UIImage *image;
    NSString *description;
    LBVenue *venue;
}

-(id)initWithLiveBrumURL:(NSURL *)aURL;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *source;
@property (nonatomic) NSString *description;
@property (nonatomic) UIImage *image;
@property (nonatomic) LBVenue *venue;

@end
