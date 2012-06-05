//
//  LBSearchViewController.h
//  LiveBrum
//
//  Created by Max Woolf on 04/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LBGeocoder.h"

@interface LBSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, LBGeocoderDelegate, CLLocationManagerDelegate, UITextFieldDelegate>
{
    IBOutlet UITableView *table;
    UITextField *keywordsField;
    IBOutlet UIButton *backgroundButton;
    LBGeocoder *geocoder;
    CLLocationManager *locationManager;
    
    UITextField *distanceField;
    UITextField *postcodeField;
    UIButton *locateButton;
    UIActivityIndicatorView *activityIndicator;
}

-(void)getPostcode;
-(BOOL)validatePostcode:(NSString *)postcode;
@end
