//
//  TestObjectiveCVC.h
//  Life
//
//  Created by Wang, Devin on 10/29/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestFunctionBaseViewController.h"

@interface TestObjectiveCVC : TestFunctionBaseViewController
@property (assign, nonatomic) NSString * testAssign;
@property (weak, nonatomic) NSString * testWeak;
@property (copy, nonatomic) NSString * testCopy;
@property (strong, nonatomic) NSString * testStrong;

- (void)testAssignWeak;
@end
