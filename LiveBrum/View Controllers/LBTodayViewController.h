//
//  LBTodayViewController.h
//  LiveBrum
//
//  Created by Max Woolf on 29/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBEventCollection.h"

@interface LBTodayViewController : UIViewController <LBEventCollectionDelegate, UITableViewDataSource, UITableViewDelegate>
{
    LBEventCollection *todayCollection;
}

@property (nonatomic) LBEventCollection *todayCollection;
@end
