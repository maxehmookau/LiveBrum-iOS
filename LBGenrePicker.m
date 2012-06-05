//
//  LBGenrePicker.m
//  LiveBrum
//
//  Created by Max Woolf on 05/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBGenrePicker.h"
#import "LBVenueBadge.h"

@implementation LBGenrePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDelegate:self];  
    }
    return self;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[LBGenrePicker genres]count];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    return [[LBVenueBadge alloc] initWithGenre:[[LBGenrePicker genres]objectAtIndex:row] frame:CGRectMake(0, 0, 250, 50) font:[UIFont systemFontOfSize:22.0]];
}

+(NSArray *)genres
{
    return [NSArray arrayWithObjects:@"Classical", @"Clubs", @"Comedy", @"Community", @"Dance", @"Digital", @"Film", @"Folk", @"Jazz", @"Rock & Pop", @"Spoken Word", @"Theatre", @"Workshops", @"World", nil];
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
