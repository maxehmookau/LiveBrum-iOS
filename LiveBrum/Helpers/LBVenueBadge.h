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
    UIFont *font;
}
- (id)initWithFrame:(CGRect)frame font:(UIFont *)aFont;
-(id)initWithGenre:(NSString *)genre frame:(CGRect)frame font:(UIFont *)aFont;

@property (nonatomic) UILabel *label;
@property (nonatomic) UIFont *font;
@end
