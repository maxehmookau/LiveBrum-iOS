//
//  LBEventViewController.m
//  LiveBrum
//
//  Created by Max Woolf on 31/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBEventViewController.h"
#import "LBGenreColours.h"
#import <QuartzCore/QuartzCore.h>
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f


@interface LBEventViewController ()

@end

@implementation LBEventViewController
@synthesize event;
-(id)initWithEvent:(LBEvent *)anEvent
{
    event = anEvent;
    return [self init];
}

#pragma mark - Table View Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //Title, venue (with distance), map, performances
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //The table is only 4 sections, so let's not bother reusing.
    static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleSubtitle
            reuseIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    if(indexPath.section == 3)
    {
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        [mapView setTag:100];
        [cell.contentView addSubview:[[event venue]mapView]];
        //[cell.contentView addSubview:[[event venue]mapView]];
    }else if(indexPath.section == 0)
    {
        [cell.textLabel setText:[event name]];
        [cell.detailTextLabel setText:[[event venue]name]];
        [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
        [cell.textLabel setNumberOfLines:1];
    }else if(indexPath.section == 2)
    {
        [cell setBackgroundColor:[UIColor clearColor]];
        UILabel *genreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [genreLabel setTag:200];
        [genreLabel setText:[event genre]];
        [genreLabel setBackgroundColor:[UIColor clearColor]];
        [genreLabel setTextAlignment:UITextAlignmentCenter];
        [genreLabel setTextColor:[UIColor whiteColor]];
        [genreLabel setFont:[UIFont systemFontOfSize:22]];
        [cell.contentView addSubview:genreLabel];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setBackgroundColor:[LBGenreColours colorForGenre:[event genre]]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }else if(indexPath.section == 1)
    {
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.textLabel setNumberOfLines:100];
        cell.textLabel.text =  [[event desc]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    }    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        CGSize textSize = [[[event desc]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, MAXFLOAT)];
        NSLog(@"%f", textSize.height);
        return MAX(textSize.height + 24.0f, 0);
    }else if (indexPath.section == 3)
    {
        return 200;
    }
    return 44;
}

- (void)viewDidLoad
{
    [self setTitle:@"Event Listing"];
    [table setBackgroundColor:[UIColor clearColor]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
