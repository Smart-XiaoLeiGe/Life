//
//  LifeManager.m
//  Life
//
//  Created by Devin on 1/27/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "LifeManager.h"

static LifeManager *instance=nil;
@implementation LifeManager

+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[LifeManager alloc] init];
    });
    return instance;
}

- (BOOL)isChinese
{
    return YES;
}
@end
