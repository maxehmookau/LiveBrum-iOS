//
//  LBTodayViewController.h
//  LiveBrum
//
//  Created by Max Woolf on 29/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBEventCollection.h"
#import "LBLoadingSpinner.h"
#import <CoreLocation/CoreLocation.h>
#import "LBVenue.h"

@interface LBTodayViewController : UIViewController <LBEventCollectionDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, LBVenueDelegate>
{
    LBEventCollection *todayCollection;
    IBOutlet UITableView *table;
    LBLoadingSpinner *spinner;
}


@property (nonatomic) LBEventCollection *todayCollection;
@end
