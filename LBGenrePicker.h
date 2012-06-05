//
//  LBGenrePicker.h
//  LiveBrum
//
//  Created by Max Woolf on 05/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBGenrePicker : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>

+(NSArray *)genres;
@end
