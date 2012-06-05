//
//  LBSearchViewController.m
//  LiveBrum
//
//  Created by Max Woolf on 04/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBSearchViewController.h"
#import "LBVenueBadge.h"
#import <QuartzCore/QuartzCore.h>

@interface LBSearchViewController ()

@end

@implementation LBSearchViewController

#pragma mark - Geocoding
-(void)getPostcode
{
    [locateButton setAlpha:0];
    [locateButton setEnabled:NO];
    [activityIndicator startAnimating];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate:self];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    geocoder = [[LBGeocoder alloc] initWithLongitude:coordinate.longitude latitude:coordinate.latitude];
    [geocoder setDelegate:self];
    [locationManager stopUpdatingLocation];
}

-(void)geocoder:(LBGeocoder *)geocoder didSuccessfullyResolvePostcode:(NSString *)postcode
{
    [postcodeField setText:postcode];
    [locateButton setAlpha:1];
    [locateButton setEnabled:YES];
    [activityIndicator stopAnimating];
    if(![self validatePostcode:[postcodeField text]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"That's not a Birmingham postcode, the results may be unusual." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
    }
}


#pragma mark - Table View Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    
    //The table is only 4 sections, so let's not bother reusing.
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleDefault
                             reuseIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if(indexPath.section == 0)
    {
        UILabel *keywordsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
        [keywordsLabel setText:@"Keywords"];
        [keywordsLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [keywordsLabel setBackgroundColor:[UIColor clearColor]];
        UILabel *optionalLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 100, 30)];
        [optionalLabel setText:@"optional"];
        [optionalLabel setBackgroundColor:[UIColor clearColor]];
        [optionalLabel setFont:[UIFont italicSystemFontOfSize:14]];
        [optionalLabel setTextColor:[UIColor grayColor]];
        keywordsField = [[UITextField alloc] initWithFrame:CGRectMake(15, 50, 250, 33)];
        [keywordsField setBorderStyle:UITextBorderStyleRoundedRect];
        [keywordsField setDelegate:self];
        [cell.contentView addSubview:keywordsLabel];
        [cell.contentView addSubview:optionalLabel];
        [cell.contentView addSubview:keywordsField];
    }else if(indexPath.section == 1)
    {
        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
        [distanceLabel setText:@"Distance"];
        [distanceLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [distanceLabel setBackgroundColor:[UIColor clearColor]];
        UILabel *optionalLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 100, 30)];
        [optionalLabel setText:@"optional"];
        [optionalLabel setBackgroundColor:[UIColor clearColor]];
        [optionalLabel setFont:[UIFont italicSystemFontOfSize:14]];
        [optionalLabel setTextColor:[UIColor grayColor]];
        distanceField = [[UITextField alloc] initWithFrame:CGRectMake(15, 55, 35, 25)];
        [distanceField setBorderStyle:UITextBorderStyleRoundedRect];
        [distanceField setKeyboardType:UIKeyboardTypeNumberPad];
        [distanceField setDelegate:self];
        UILabel *mLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 60, 50, 20)];
        [mLabel setBackgroundColor:[UIColor clearColor]];
        [mLabel setFont:[UIFont italicSystemFontOfSize:14]];
        [mLabel setText:@"m from"];
        postcodeField = [[UITextField alloc] initWithFrame:CGRectMake(105, 55, 100, 25)];
        [postcodeField setBorderStyle:UITextBorderStyleRoundedRect];
        [postcodeField setPlaceholder:@"postcode"];
        [postcodeField setDelegate:self];
        [postcodeField setAutocorrectionType:UITextAutocorrectionTypeNo];
        locateButton = [[UIButton alloc] initWithFrame:CGRectMake(195, 43, 50, 50)];
        [locateButton setImage:[UIImage imageNamed:@"74-location.png"] forState:UIControlStateNormal];
        [locateButton setShowsTouchWhenHighlighted:YES];
        [locateButton addTarget:self action:@selector(getPostcode) forControlEvents:UIControlEventTouchUpInside];
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(195, 43, 50, 50)];
        [activityIndicator setHidesWhenStopped:YES];
        [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        
        
        [cell.contentView addSubview:distanceLabel];
        [cell.contentView addSubview:optionalLabel];
        [cell.contentView addSubview:mLabel];
        [cell.contentView addSubview:distanceField];
        [cell.contentView addSubview:postcodeField];
        
        //Only display these if we're authorised
        if([CLLocationManager authorizationStatus])
        {
            [cell.contentView addSubview:locateButton];
            [cell.contentView addSubview:activityIndicator];
        }
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 100;
    }else if(indexPath.section == 1)
    {
        return 100;
    }
    return 44;
}

#pragma mark - First Responding
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField == postcodeField)
    {
        if(![self validatePostcode:[textField text]])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"That's not a Birmingham postcode, the results may be unusual." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [alert show];
        }
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == distanceField || textField == postcodeField)
    {
        [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - Validation
-(BOOL)validatePostcode:(NSString *)postcode
{
    if ([[postcode substringToIndex:1]isEqualToString:@"B"])
    {
        return YES;
    }
    return NO;
}

#pragma mark - View Loading
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithWhite:0 alpha:1]];
    [self setTitle:@"Search"];

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
