#import "LBEventCollection.h"
#import "SBJson.h"

@implementation LBEventCollection
@synthesize events, delegate;

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
    NSDictionary *root = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    //Now parse all this data and convert it to LBEvent objects.
    NSLog(@"%@", [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding]);
}

#pragma mark - Parse and Convert Data

@end
