#import "LBEventCollection.h"
#import "LBEvent.h"
#import "SBJson.h"
#include "NSDictionary_JSONExtensions.h"

@implementation LBEventCollection
@synthesize events, delegate;

#pragma mark - Initialisers
-(id)initWithDate:(NSString *)aDate month:(NSString *)aMonth year:(NSString *)aYear
{
    //Permalink in this format http://livebrum.co.uk/YYYY/MM/DD.json
    //Go get that data.
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://www.livebrum.co.uk/%@/%@/%@.json", aYear, aMonth, aDate];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:15];
    NSString *cacheContent = [[NSString alloc] initWithData:[[[NSURLCache sharedURLCache] cachedResponseForRequest:request]data] encoding:NSUTF8StringEncoding];
        NSURLConnection *collectionConn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if([[NSURLCache sharedURLCache]cachedResponseForRequest:request] == nil)
    {
        
        [collectionConn start];
    }else{
        [receivedData appendData:[[[NSURLCache sharedURLCache]cachedResponseForRequest:request]data]];
        [delegate collectionDidFinishLoading];
        NSLog(@"%@",cacheContent);
    }
    
    return [super init];
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    //NSLog(@"%@", [cachedResponse description]);
    return cachedResponse;
}


-(id)withTodaysEvents
{
    NSDate *curentDate = [NSDate date];
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    [monthFormatter setDateFormat:@"MM"];
    [dateFormatter setDateFormat:@"dd"];
    
    NSString *todaysDate = [dateFormatter stringFromDate:curentDate];
    NSLog(@"%@", todaysDate);
    return [self initWithDate:[dateFormatter stringFromDate:curentDate] month:[monthFormatter stringFromDate:curentDate] year:[yearFormatter stringFromDate:curentDate]];
}

#pragma mark - Receiving data
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

//Called once the JSON has finished downloading. 
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    id rootObject = [NSJSONSerialization
                     JSONObjectWithData:receivedData
                     options:0
                     error:&error];

    root = rootObject;
    [self convertToEvents];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //Connection failed, pass the delegate the error. 
    [delegate collectionFailedToLoadWithError:error];
}

#pragma mark - Convert Data to Events
-(int)numberOfEventsInCollection
{
    return [[root objectForKey:@"performances"]count];
}

-(void)convertToEvents
{
    //Can't deal with '!
    completedEvents = 0;
    events = [[NSMutableArray alloc] initWithCapacity:[self numberOfEventsInCollection]];
    for (int x = 0; x < [self numberOfEventsInCollection]; x++)
    {
        NSDictionary *currentEvent = [[root objectForKey:@"performances"] objectAtIndex:x];
        LBEvent *newEvent = [[LBEvent alloc] initWithLiveBrumURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@.json", [[currentEvent valueForKey:@"url"]stringByReplacingOccurrencesOfString:@"’" withString:@"%E2%80%99"]]]];
        [newEvent setDelegate:self];
        NSLog(@"%@", [[currentEvent valueForKey:@"url"]stringByReplacingOccurrencesOfString:@"’" withString:@"%E2%80%99"]);
        [events addObject:newEvent];
    }    
}

-(void)eventDidFinishLoading
{
    completedEvents = completedEvents + 1;
    if(completedEvents >= [self numberOfEventsInCollection]-1)
    {
        [delegate collectionDidFinishLoading];
    }
}
@end
