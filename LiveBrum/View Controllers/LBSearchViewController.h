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
#import "LBGenrePicker.h"

@interface LBSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, LBGeocoderDelegate, CLLocationManagerDelegate, UITextFieldDelegate>
{
    IBOutlet UITableView *table;
    UITextField *keywordsField;
    LBGeocoder *geocoder;
    CLLocationManager *locationManager;
    
    UITextField *distanceField;
    UITextField *postcodeField;
    UIButton *locateButton;
    UIActivityIndicatorView *activityIndicator;
    LBGenrePicker *genrePicker;
    UILabel *genreLabel;
}

-(void)getPostcode;
-(BOOL)validatePostcode:(NSString *)postcode;
-(void)pickerTapped:(UIGestureRecognizer *)gestureRecognizer;
-(void)customPickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component asResultOfTap:(bool)userTapped;
@end
