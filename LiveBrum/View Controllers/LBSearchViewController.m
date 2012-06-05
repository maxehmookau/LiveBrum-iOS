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
#import "LBGenreColours.h"
#import "LBGenrePicker.h"

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
        
    }else if(indexPath.section == 2)
    {
        [cell setBackgroundColor:[UIColor clearColor]];
        genreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [genreLabel setText:@"Genre"];
        [genreLabel setBackgroundColor:[UIColor clearColor]];
        [genreLabel setTextAlignment:UITextAlignmentCenter];
        [genreLabel setTextColor:[UIColor whiteColor]];
        [genreLabel setFont:[UIFont systemFontOfSize:22]];
        [cell.contentView addSubview:genreLabel];
        [cell setBackgroundColor:[LBGenreColours colorForGenre:@"Spoken Word"]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
        [genrePicker setFrame:CGRectMake(0, 190, 320, 180)];
        
        [UIView commitAnimations];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
#pragma mark - Picker
-(void)pickerTapped:(UIGestureRecognizer *)gestureRecognizer {
    //determine location of tap inside UIPickerView
    CGPoint myP = [gestureRecognizer locationInView:genrePicker];
    //find height of single UIPickerRow (5 equal rows)
    CGFloat heightOfPickerRow = genrePicker.frame.size.height/5;
    //declare variable to store selected row
    NSInteger rowToSelect =[genrePicker selectedRowInComponent:0];
    //Analyse if any action on the tap is required
    if (myP.y<heightOfPickerRow) {
        //selected area corresponds to current_row-2 row
        //check if we can move to that row (i.e. that
        //it exists and is not blank
        if ([genrePicker selectedRowInComponent:0] > 1)
            rowToSelect -=2;
        else
            rowToSelect = -1; //no action required code
    }
    else if (myP.y<2*heightOfPickerRow) {
        //selected area corresponds to current_row-1 row
        //check if we can move to that row (i.e. that
        //it exists and is not blank
        if ([genrePicker selectedRowInComponent:0] > 0)
            rowToSelect -=1;
        else
            rowToSelect = -1; //no action required code
    }
    else if (myP.y<3*heightOfPickerRow) {
        //selected the already highlighted row.
        //it definitely exists so no further checks needed
        rowToSelect = [genrePicker selectedRowInComponent:0];
    }
    else if (myP.y<4*heightOfPickerRow) {
        //selected area corresponds to current_row+1 row
        //check if we can move to that row (i.e. that
        //it exists and is not blank
        if ([genrePicker selectedRowInComponent:0] <
            ([genrePicker numberOfRowsInComponent:0]-1))
            rowToSelect +=1;
        else
            rowToSelect = -1; //no action required code
    }
    else {
        //selected area corresponds to current_row+2 row
        //check if we can move to that row (i.e. that
        //it exists and is not blank
        if ([genrePicker selectedRowInComponent:0] <
            ([genrePicker numberOfRowsInComponent:0]-2))
            rowToSelect +=2;
        else
            rowToSelect = -1; //no action required code
    }
    //check that we do need to process the tap
    if (rowToSelect!=-1) {
        //tell picker view to scroll to required row
        //ATTENTION - didSelectRow method is not called when you
        //tell the picker to move to select some row
        [genrePicker selectRow:rowToSelect inComponent:0 animated:YES];
        //hence we need another function
        [self customPickerView:genrePicker didSelectRow:rowToSelect inComponent:0
                 asResultOfTap:YES];
    }
}

-(void)customPickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
            inComponent:(NSInteger)component  asResultOfTap:(bool)userTapped{
    //We will hide the picker when userTapped and currently stored selectedRow
    //is equal to the one that use selected just now
    bool needsHiding = userTapped && ([pickerView selectedRowInComponent:0] == row);
    
    if (!needsHiding) {
        NSLog(@"%i", row);
    }
    else{
        [genreLabel setText:[[LBGenrePicker genres]objectAtIndex:[pickerView selectedRowInComponent:0]]];
        [[table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]]setBackgroundColor:[LBGenreColours colorForGenre:[[LBGenrePicker genres]objectAtIndex:[pickerView selectedRowInComponent:0]]]];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        [genrePicker setFrame:CGRectMake(0, 370, 320, 180)];
        
        [UIView commitAnimations];

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
    genrePicker = [[LBGenrePicker alloc] initWithFrame:CGRectMake(0, 370, 320, 180)];
    [self.view addSubview:genrePicker];
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] 
                                          initWithTarget:self
                                          action:@selector(pickerTapped:)];
    [genrePicker addGestureRecognizer:tapgesture];

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
