//
//  TestFingerPrintVC.m
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestFingerPrintVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TestFingerPrintVC ()

@end

@implementation TestFingerPrintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testTouchID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testTouchID
{
    LAContext *context = [LAContext new];
    
    NSError *error;
    context.localizedFallbackTitle = @"456";
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"Touch ID is available.");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"123" reply:^(BOOL success, NSError *error) {
            if (success) {
                NSLog(@"Touch ID is success: %@", @(success));
            }else
            {
                NSLog(@"Touch ID is fail: %@", error);
            }
        }];
    }else {
        NSLog(@"Touch ID is not available: %@", error);
    }
}


@end
