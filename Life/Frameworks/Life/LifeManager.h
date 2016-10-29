//
//  LifeManager.h
//  Life
//
//  Created by Devin on 1/27/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LifeManager : NSObject

+ (instancetype)shareManager;
- (BOOL)isChinese;

@end
