//
//  AppMonitorManager.h
//  Life
//
//  Created by Devin on 4/24/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppMonitorManager : NSObject
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end
