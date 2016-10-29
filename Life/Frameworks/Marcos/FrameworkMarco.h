//
//  FrameworkMarco.h
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#ifndef FrameworkMarco_h
#define FrameworkMarco_h

#define FM_iOSSystemVersion [[[UIDevice currentDevice]systemVersion] floatValue]
#define FM_iOS7OrLater      [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define FM_iOS8OrLater      [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0
#define FM_iOS9OrLater      [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0

#define FM_ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define FM_ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define FM_ScreenBounds    [UIScreen mainScreen].bounds
#define FM_FrameScale      [UIScreen mainScreen].scale

#define FM_iSSmall4INCH ([UIScreen mainScreen].bounds.size.height<568)//4/4s
#define FM_iS4INCH ([UIScreen mainScreen].bounds.size.height>480)//5
#define FM_iSLarge4INCH ([UIScreen mainScreen].bounds.size.height>568)//6/6+
#define FM_iSLarge47Inch ([UIScreen mainScreen].bounds.size.height>667)//6+

#define FM_UIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define FM_UIColorWithRGBAlpha(r,g,b,α) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:α]

#define FM_ARC4RANDOM_MAX 0x100000000

//Temp section 
#define FM_BaseVCBackgroundColor     [UIColor lightTextColor]

//Temp section

#endif /* FrameworkMarco_h */
