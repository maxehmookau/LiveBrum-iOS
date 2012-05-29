#import "LBEventCollection.h"
#import "LBEvent.h"
#import "SBJson.h"

@implementation LBEventCollection
@synthesize events, delegate;

#pragma mark - Initialisers
-(id)initWithDate:(NSString *)aDate month:(NSString *)aMonth year:(NSString *)aYear
{
    //Permalink in this format http://livebrum.co.uk/YYYY/MM/DD.json
    //Go get that data.
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://www.livebrum.co.uk/%@/%@/%@.json", aYear, aMonth, aDate];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *collectionConn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [collectionConn start];
    return [super init];
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
    root = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] JSONValue];
    [self convertToEvents];
}

#pragma mark - Convert Data to Events
-(int)numberOfEventsInCollection
{
    return [[root objectForKey:@"performances"]count];
}

-(void)convertToEvents
{
    for (int x = 0; x < [self numberOfEventsInCollection]; x++)
    {
        NSDictionary *currentEvent = [[root objectForKey:@"performances"] objectAtIndex:x];
        [events addObject:[[LBEvent alloc] initWithLiveBrumURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@.json", [currentEvent valueForKey:@"url"]]]]];
    }
    
    //Let the delegate know we're done here.
    [delegate dataDidFinishLoading];
}
@end
