//
//  BookActivity.m
//  Life
//
//  Created by Devin on 5/18/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "BookActivity.h"

@implementation BookActivity

+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryShare;
}

- (NSString *)activityType  {
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle {
    return NSLocalizedStringFromTable(@"Open Book", @"BookActivity", nil);
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"chuang"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSURL class]]) {
            if ([[UIApplication sharedApplication] canOpenURL:activityItem]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSURL class]]) {
            _url = activityItem;
        }
    }
}

- (void)performActivity {
    BOOL completed = [[UIApplication sharedApplication] openURL:_url];
    [self activityDidFinish:completed];
}

@end
