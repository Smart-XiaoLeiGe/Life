//
//  UIImage+Tint.h
//  RMEO
//
//  Created by Faney on 14-3-18.
//  Copyright (c) 2014年 RMEO. All rights reserved.
//

@interface UIImage (Tint)

// 图片换颜色
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

// 图片虚化
- (UIImage *)blurryImage:(CGFloat)blur;

@end
