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
@synthesize label, font;
- (id)initWithFrame:(CGRect)frame font:(UIFont *)aFont;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        [label setFont:aFont];
        [label setTextColor:[UIColor colorWithWhite:9 alpha:1]];
        [label setTextAlignment:UITextAlignmentCenter];
        float viewWidth = self.frame.size.width;
        float viewHeight = self.frame.size.height;
        float labelWidth = label.frame.size.width;
        float labelHeight = label.frame.size.height;
        float xpos = (viewWidth/2.0f) - (labelWidth/2.0f);
        float ypos = (viewHeight/2.0f) - (labelHeight/2.0f);
        [label setFrame:CGRectMake(xpos,ypos,labelWidth,labelHeight)];
        [label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:label];
        [self setBackgroundColor:[UIColor greenColor]];
    }
    return self;
}

-(id)initWithGenre:(NSString *)genre frame:(CGRect)frame font:(UIFont *)aFont
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
        [label setFont:aFont];
        [label setTextColor:[UIColor colorWithWhite:9 alpha:1]];
        [label setTextAlignment:UITextAlignmentCenter];
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
