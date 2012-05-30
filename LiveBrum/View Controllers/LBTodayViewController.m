//
//  LBTodayViewController.m
//  LiveBrum
//
//  Created by Max Woolf on 29/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBTodayViewController.h"
#import "LBGenreColours.h"
#import "LBVenueBadge.h"

@interface LBTodayViewController ()

@end

@implementation LBTodayViewController
@synthesize todayCollection;

#pragma mark - Table View Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [todayCollection numberOfEventsInCollection];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

//    if(indexPath.row % 2 == 1)
//    {
//        [cell setBackgroundColor:[UIColor grayColor]];
//    }else{
//        [cell setBackgroundColor:[UIColor lightGrayColor]];
//    }
    //[cell setBackgroundColor:[LBGenreColours colorForGenre:[[[todayCollection events]objectAtIndex:indexPath.row]genre]]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
    [headerLabel setText:[[[todayCollection events]objectAtIndex:indexPath.row]name]];
    [headerLabel setFont:[UIFont boldSystemFontOfSize:22]];
    
    UILabel *venueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 300, 40)];
    [venueLabel setText:[[[todayCollection events]objectAtIndex:indexPath.row]venue]];
    [venueLabel setFont:[UIFont italicSystemFontOfSize:16]];

    LBVenueBadge *venueBadge = [[LBVenueBadge alloc] initWithGenre:[[[todayCollection events]objectAtIndex:indexPath.row]genre] frame:CGRectMake(190, 60, 100, 20)];
    
    [containerView addSubview:headerLabel];
    [containerView addSubview:venueLabel];
    [containerView addSubview:venueBadge];
    cell.backgroundView = containerView;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
} 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - Initialisation
-(void)collectionDidFinishLoading
{
    [table reloadData];
}

-(void)collectionFailedToLoadWithError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    [errorAlert show];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated    
{
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithWhite:0 alpha:1]];
    [self setTitle:@"Today"];
    todayCollection = [[LBEventCollection alloc] withTodaysEvents];
    [todayCollection setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
