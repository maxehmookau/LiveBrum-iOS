//
//  LBVenueBadge.m
//  LiveBrum
//
//  Created by Max Woolf on 30/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBVenueBadge.h"
#import "LBGenreColours.h"
#import <QuartzCore/QuartzCore.h>

@implementation LBVenueBadge

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(id)initWithGenre:(NSString *)genre frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setTextColor:[UIColor colorWithWhite:9 alpha:1]];
        [label setText:genre];
        float viewWidth = self.frame.size.width;
        float viewHeight = self.frame.size.height;
        float labelWidth = label.frame.size.width;
        float labelHeight = label.frame.size.height;
        float xpos = (viewWidth/2.0f) - (labelWidth/2.0f);
        float ypos = (viewHeight/2.0f) - (labelHeight/2.0f);
        [label setFrame:CGRectMake(xpos,ypos,labelWidth,labelHeight)];
        [label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:label];
        [self setBackgroundColor:[LBGenreColours colorForGenre:genre]];
    }
    return self;
}

//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    
//}


@end
