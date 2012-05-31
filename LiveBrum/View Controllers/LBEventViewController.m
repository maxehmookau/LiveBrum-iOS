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
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
        if(indexPath.section == 2)
        {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.contentView addSubview:[[event venue]mapView]];
        }else if(indexPath.section == 0)
        {
            [cell.textLabel setText:[event name]];
            [cell.detailTextLabel setText:[[event venue]name]];
        }else if(indexPath.section == 1)
        {
            UILabel *genreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
            [genreLabel setText:[event genre]];
            [genreLabel setBackgroundColor:[UIColor clearColor]];
            [genreLabel setTextAlignment:UITextAlignmentCenter];
            [genreLabel setTextColor:[UIColor whiteColor]];
            [genreLabel setFont:[UIFont systemFontOfSize:22]];
            [cell.contentView addSubview:genreLabel];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setBackgroundColor:[LBGenreColours colorForGenre:[event genre]]];
        }
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 2:
            return 200;
            break;
            
        default:
            return 44;
            break;
    }
}
- (void)viewDidLoad
{
    [self setTitle:@"Event Listing"];
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
