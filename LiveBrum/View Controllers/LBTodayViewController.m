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
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 40)];
        [headerLabel setFont:[UIFont boldSystemFontOfSize:22]];
        [headerLabel setTag:100];
        
        UILabel *venueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 20)];
        [venueLabel setFont:[UIFont italicSystemFontOfSize:16]];
        [venueLabel setTag:200];
        
        LBVenueBadge *venueBadge = [[LBVenueBadge alloc] initWithGenre:[[[todayCollection events]objectAtIndex:indexPath.row]genre] frame:CGRectMake(85, 73, 100, 20)];
        [venueBadge setTag:300];
        
        UIImageView *pinImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, 18, 18)];
        [pinImage setImage:[UIImage imageNamed:@"193-location-arrow.png"]];
        [pinImage setTag:400];
        
        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 75, 100, 15)];
        [distanceLabel setFont:[UIFont systemFontOfSize:12]];
        [distanceLabel setTag:500];
        
        UILabel *performanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 75, 50, 15)];
        [performanceLabel setTag:600];
        [performanceLabel setFont:[UIFont boldSystemFontOfSize:12]];

        
        [cell.contentView addSubview:headerLabel];
        [cell.contentView addSubview:venueLabel];
        [cell.contentView addSubview:distanceLabel];
        [cell.contentView addSubview:pinImage];
        [cell.contentView addSubview:venueBadge];
        [cell.contentView addSubview:performanceLabel];

    }
    
    UILabel *headerLabel = (UILabel *) [cell.contentView viewWithTag:100];
    headerLabel.text = [[[todayCollection events]objectAtIndex:indexPath.row]name];
    
    UILabel *venueLabel = (UILabel *) [cell.contentView viewWithTag:200];
    venueLabel.text = [[[[todayCollection events]objectAtIndex:indexPath.row]venue]name];
    
    UIImageView *pinImage = (UIImageView *) [cell.contentView viewWithTag:400];
    [pinImage setImage:[UIImage imageNamed:@"193-location-arrow.png"]];
    
    UILabel *distanceLabel = (UILabel *)[cell.contentView viewWithTag:500];
    distanceLabel.text = [[[[todayCollection events]objectAtIndex:indexPath.row]venue]distanceString];
    
    UILabel *performanceLabel = (UILabel *) [cell.contentView viewWithTag:600];
    if([[[[todayCollection events]objectAtIndex:indexPath.row]performances]count] == 1)
    {
        [performanceLabel setText:[[[[[todayCollection events]objectAtIndex:indexPath.row]performances]objectAtIndex:0]time]];
    }else{
        [performanceLabel setText:[NSString stringWithFormat:@"%i shows", [[[[todayCollection events]objectAtIndex:indexPath.row]performances]count]]];
    }   
//    if(indexPath.row % 2 == 0)
//    {
//        [cell setBackgroundColor:[UIColor colorWithRed:0.239 green:0.239 blue:0.232 alpha:0.05]];
//    }else{
//        [cell setBackgroundColor:[UIColor colorWithRed:0.239 green:0.239 blue:0.232 alpha:0.02]];
//    }
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
    [table setNeedsDisplay];
    [table setNeedsLayout];
    for (int x = 0; x < [[todayCollection events]count]; x++)
    {
        [[[[todayCollection events]objectAtIndex:x]venue]setDelegate:self];
    }
    [UIView animateWithDuration:0.5
                     animations:^{spinner.alpha = 0.0;}
                     completion:^(BOOL finished){ [spinner removeFromSuperview]; }];
    
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

-(void)userMoved
{
    [table reloadData];
}


-(void)viewWillAppear:(BOOL)animated    
{
    spinner = [[LBLoadingSpinner alloc] init];
    [self.view addSubview:spinner];
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
