#import "LBEvent.h"
#import "SBJson.h"

@implementation LBEvent
@synthesize name, desc, image, delegate, dateRange, genre, venue;


#pragma mark - Initialisers
-(id)initWithLiveBrumURL:(NSURL *)aURL
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:aURL];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    return [super init];
}


#pragma mark - Data Delegates
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self parseReceivedData];
}


#pragma mark - Data Parsing
-(void)parseReceivedData
{
    rootDictionary = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] JSONValue];
    name = [rootDictionary valueForKey:@"title"];
    desc = [rootDictionary valueForKey:@"description"];
    dateRange = [rootDictionary valueForKey:@"date_range"];
    genre = [[rootDictionary objectForKey:@"genre"] valueForKey:@"title"];
    venue = [[LBVenue alloc] initWithName:[[rootDictionary objectForKey:@"venue"] valueForKey:@"title"] description:[[rootDictionary objectForKey:@"venue"] valueForKey:@"description"]];
    
    //Alert the delegate when we're done, if there is a delegate.
    [delegate eventDidFinishLoading];
}
@end
