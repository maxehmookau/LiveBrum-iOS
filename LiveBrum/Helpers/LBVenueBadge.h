//
//  LBVenueBadge.h
//  LiveBrum
//
//  Created by Max Woolf on 30/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBVenueBadge : UIView
{
    UILabel *label;
}
-(id)initWithGenre:(NSString *)genre frame:(CGRect)frame;

@property (nonatomic) UILabel *label;
@end
