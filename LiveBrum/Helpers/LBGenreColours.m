//
//  LBGenreColours.m
//  LiveBrum
//
//  Created by Max Woolf on 30/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LBGenreColours.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation LBGenreColours

+(UIColor *)colorForGenre:(NSString *)aGenre
{
    if([aGenre isEqualToString:@"art"])
    {
        return [LBGenreColours artColor];
    }else if([aGenre isEqualToString:@"classical"])
    {
        return [LBGenreColours classicalColor];
    }else if([aGenre isEqualToString:@"club"])
    {
        return [LBGenreColours clubColor];
    }else if([aGenre isEqualToString:@"comedy"])
    {
        return [LBGenreColours comedyColor];
    }else if([aGenre isEqualToString:@"community"])
    {
        return [LBGenreColours communityColor];
    }else if ([aGenre isEqualToString:@"dance"])
    {
        return [LBGenreColours danceColor];
    }else if([aGenre isEqualToString:@"film"])
    {
        return [LBGenreColours filmColor];
    }else if([aGenre isEqualToString:@"folk"])
    {
        return [LBGenreColours folkColor];
    }else if([aGenre isEqualToString:@"jazz"])
    {
        return [LBGenreColours jazzColor];
    }else if([aGenre isEqualToString:@"rock"])
    {
        return [LBGenreColours rockColor];
    }else if([aGenre isEqualToString:@"spokenWord"])
    {
        return [LBGenreColours spokenWordColor];
    }else if([aGenre isEqualToString:@"theatre"])
    {
        return [LBGenreColours theatreColor];
    }else if([aGenre isEqualToString:@"workshop"])
    {
        return [LBGenreColours workshopColor];
    }else if([aGenre isEqualToString:@"world"])
    {
        return [LBGenreColours worldColor];
    }else if([aGenre isEqualToString:@"digital"])
    {
        return [LBGenreColours digitalColor];
    }else if([aGenre isEqualToString:@"general"])
    {
        return [LBGenreColours generalColor];
    }else if([aGenre isEqualToString:@"news"])
    {
        return [LBGenreColours newsColor];
    }else {
        return [LBGenreColours generalColor];
    }
}

+(UIColor *)artColor
{
    return UIColorFromRGB(0xF09F00);
}

+(UIColor *)classicalColor
{
    return UIColorFromRGB(0x309945);
}

+(UIColor *)clubColor
{
    return UIColorFromRGB(0x9B3B85);
}

+(UIColor *)comedyColor
{
    return UIColorFromRGB(0x4481D5);
}

+(UIColor *)communityColor
{
    return UIColorFromRGB(0x4ED28E);
}

+(UIColor *)danceColor
{
    return UIColorFromRGB(0xC975B8);
}

+(UIColor *)filmColor
{
    return UIColorFromRGB(0x5225FF);
}

+(UIColor *)folkColor
{
    return UIColorFromRGB(0x5EB0B7);
}

+(UIColor *)jazzColor
{
    return UIColorFromRGB(0xE4B81E);
}

+(UIColor *)rockColor
{
    return UIColorFromRGB(0xB3333F);
}

+(UIColor *)spokenWordColor
{
    return UIColorFromRGB(0x8A3BC9);
}

+(UIColor *)theatreColor
{
    return UIColorFromRGB(0xB5543B);
}

+(UIColor *)workshopColor
{
    return UIColorFromRGB(0x879C4A);
}

+(UIColor *)worldColor
{
    return UIColorFromRGB(0xB78449);
}

+(UIColor *)digitalColor
{
    return UIColorFromRGB(0xABCF44);
}

+(UIColor *)generalColor
{
    return UIColorFromRGB(0x839FA5);
}

+(UIColor *)newsColor
{
    return UIColorFromRGB(0x7D8465);
}
@end