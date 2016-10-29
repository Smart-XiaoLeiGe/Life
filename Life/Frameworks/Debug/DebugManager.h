//
//  DebugManager.h
//  Life
//
//  Created by Devin on 1/31/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^DebugPageBlock)();
@interface DebugManager : NSObject
{
    UIButton *debugButton;
}

-(void)setDebugManager:(UIViewController *)taretVC withDebugPageBlock:(DebugPageBlock)showDebugPageBlock hideBlock:(DebugPageBlock)hideDebugPageBlock gestureAction:(SEL)gestureAction;
-(void)debugGestureAction:(UILongPressGestureRecognizer *)gesture;
-(void)hideDebugView:(id)sender;

@end
