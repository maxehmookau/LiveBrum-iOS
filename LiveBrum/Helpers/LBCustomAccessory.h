//
//  LBCustomAccessory.h
//  LiveBrum
//
//  Created by Max Woolf on 04/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBCustomAccessory : UIControl
{
	UIColor *_accessoryColor;
	UIColor *_highlightedColor;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

+ (LBCustomAccessory *)accessoryWithColor:(UIColor *)color;

@end
