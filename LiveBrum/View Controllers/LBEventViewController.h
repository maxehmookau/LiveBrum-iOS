//
//  LBEventViewController.h
//  LiveBrum
//
//  Created by Max Woolf on 31/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBEvent.h"

@interface LBEventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    LBEvent *event;
}
-(id)initWithEvent:(LBEvent *)anEvent;

@property (nonatomic) LBEvent *event;
@end
