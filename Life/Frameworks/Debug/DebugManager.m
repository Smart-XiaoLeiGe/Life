//
//  DebugManager.m
//  Life
//
//  Created by Devin on 1/31/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "DebugManager.h"
#import "AppDelegate.h"
#import "DebugViewController.h"

@interface DebugManager ()
{
     DebugPageBlock showDebugPage;
     DebugPageBlock hideDebugPage;
     UIViewController *taretViewController;
     DebugViewController *debugVC;
}

@end
@implementation DebugManager

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark - Send Log Using Mail
-(void)setDebugManager:(UIViewController *)taretVC withDebugPageBlock:(DebugPageBlock)showDebugPageBlock hideBlock:(DebugPageBlock)hideDebugPageBlock gestureAction:(SEL)gestureAction
{
#ifdef DEBUG
    UILongPressGestureRecognizer *threeFingersLongPressGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:taretVC action:gestureAction];
    threeFingersLongPressGesture.minimumPressDuration=2;
    threeFingersLongPressGesture.numberOfTouchesRequired=1;
    [taretVC.view addGestureRecognizer:threeFingersLongPressGesture];
    [self addSendLogUsingMailButton];
#else
    UILongPressGestureRecognizer *threeFingersLongPressGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:taretVC action:gestureAction];
    threeFingersLongPressGesture.minimumPressDuration=10;
    threeFingersLongPressGesture.numberOfTouchesRequired=3;
    [taretVC.view addGestureRecognizer:threeFingersLongPressGesture];
#endif
    taretViewController=taretVC;
    showDebugPage = showDebugPageBlock;
    hideDebugPage = hideDebugPageBlock;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideDebugView:) name:BackDebugPageNotification object:nil];
}

-(void)showDebugButton
{
    if (debugButton) {
        [debugButton removeFromSuperview];
        debugButton=nil;
        [self distoryDebugVC];
    }else
    {
        [self addSendLogUsingMailButton];
    }
}

-(void)distoryDebugVC
{
    [debugVC.view removeFromSuperview];
    debugVC.view=nil;
    debugVC=nil;
}

-(void)debugGestureAction:(UILongPressGestureRecognizer *)gesture
{
    BOOL isInHotPoint=NO;
    CGRect hotPointRect=CGRectMake(0, 0, FM_ScreenWidth, FM_ScreenHeight*1/3);
    if (gesture.numberOfTouchesRequired==1) {
        CGPoint onePoint = [gesture locationOfTouch:0 inView:gesture.view];
        isInHotPoint=CGRectContainsPoint(hotPointRect, onePoint);
    }
    if (gesture.numberOfTouchesRequired==3) {
        CGPoint onePoint   = [gesture locationOfTouch:0 inView:gesture.view];
        CGPoint twoPoint   = [gesture locationOfTouch:1 inView:gesture.view];
        CGPoint threePoint = [gesture locationOfTouch:2 inView:gesture.view];
        isInHotPoint=CGRectContainsPoint(hotPointRect, onePoint) && CGRectContainsPoint(hotPointRect, twoPoint) && CGRectContainsPoint(hotPointRect, threePoint);
        if (isInHotPoint) {
            NSLog(@"1:%@, 2:%@, 3:%@, ",NSStringFromCGPoint(onePoint),NSStringFromCGPoint(twoPoint),NSStringFromCGPoint(threePoint));
        }
    }
    if (gesture.state == UIGestureRecognizerStateEnded && isInHotPoint)
    {
        [self showDebugButton];
    }
}

- (void)addSendLogUsingMailButton
{
    debugButton=[[UIButton alloc] initWithFrame:CGRectMake(FM_ScreenWidth-80, 300, 80, 50)];
    [debugButton setTitle:@"Debug" forState:UIControlStateNormal];
    [debugButton addTarget:self action:@selector(addDebugView) forControlEvents:UIControlEventTouchUpInside];
    [debugButton setBackgroundColor:[UIColor orangeColor]];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestures:)];
    pan.minimumNumberOfTouches = 1;
    pan.maximumNumberOfTouches = 1;
    [debugButton addGestureRecognizer:pan];
    
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:debugButton];
}

-(void)handlePanGestures:(UIPanGestureRecognizer *)paramSender{
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed) {
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
    }
}

- (void)addDebugView
{
    showDebugPage();
    if (!debugVC) {
        debugVC=[[DebugViewController alloc] init];
        debugVC.view.frame = [UIScreen mainScreen].bounds;
    }
    [taretViewController.navigationController pushViewController:debugVC animated:YES];

}

-(void)hideDebugView:(id)sender
{
    hideDebugPage();
    [taretViewController.navigationController popViewControllerAnimated:YES];
    [self distoryDebugVC];
}

@end
