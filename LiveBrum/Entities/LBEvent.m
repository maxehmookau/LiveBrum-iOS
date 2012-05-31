#import "LBEvent.h"
#import "SBJson.h"
#import "LBPerformance.h"

@implementation LBEvent
@synthesize name, desc, image, delegate, dateRange, genre, venue, performances;


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
    NSError *error = nil;
    rootDictionary = [NSJSONSerialization
                                      JSONObjectWithData:receivedData
                                      options:0
                                      error:&error];

    name = [rootDictionary valueForKey:@"title"];
    desc = [rootDictionary valueForKey:@"description"];
    dateRange = [rootDictionary valueForKey:@"date_range"];
    genre = [[rootDictionary objectForKey:@"genre"] valueForKey:@"title"];
    venue = [[LBVenue alloc] initWithName:[[rootDictionary objectForKey:@"venue"] valueForKey:@"title"] description:[[rootDictionary objectForKey:@"venue"] valueForKey:@"description"]];
    performances = [[NSMutableArray alloc] initWithCapacity:[self numberOfPerformances]];
    for (int x = 0; x < [self numberOfPerformances]; x++)
    {
        [performances addObject:[[LBPerformance alloc] initWithDate:[[[rootDictionary objectForKey:@"performances"]objectAtIndex:x]valueForKey:@"date"]]];
    }
    //Alert the delegate when we're done, if there is a delegate.
    [delegate eventDidFinishLoading];
}
      
-(int)numberOfPerformances
{
    return [[rootDictionary objectForKey:@"performances"]count];
}
@end
