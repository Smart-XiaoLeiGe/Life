//
//  UMengsManager.h
//  Life
//
//  Created by Devin on 1/26/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^UpdateBlock)(BOOL isForceUpdate, NSString * updateString, NSString *appPath);
@interface UMengsManager : NSObject

+(void)checkUpdate:(UpdateBlock)update;
+ (void)setUMengAnalytics;
+ (void)setUMengSocial;

@end
