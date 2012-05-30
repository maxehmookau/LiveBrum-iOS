//
//  LBLoadingSpinner.m
//  LiveBrum
//
//  Created by Max Woolf on 30/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBLoadingSpinner.h"
#import <QuartzCore/QuartzCore.h>

@implementation LBLoadingSpinner

- (id)init
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        
        UIView *outerSquare = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
        [outerSquare setBackgroundColor:[UIColor blackColor]];
        [outerSquare setAlpha:0.7];
        [self addSubview:outerSquare];
        
        UIView *innerSquare = [[UIView alloc] initWithFrame:CGRectMake(110, 120, 100, 100)];
        [innerSquare setBackgroundColor:[UIColor grayColor]];
        [innerSquare.layer setCornerRadius:5];
        [innerSquare.layer setMasksToBounds:YES];
        [innerSquare setAlpha:0.89];
        [self addSubview:innerSquare];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator startAnimating];
        [innerSquare addSubview:indicator];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
