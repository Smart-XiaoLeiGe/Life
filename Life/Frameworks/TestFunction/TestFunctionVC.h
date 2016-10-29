//
//  TestFunctionVC.h
//  Life
//
//  Created by Devin on 3/21/15.
//  Copyright (c) 2015 wanglei. All rights reserved.
//
#import "TestFunctionBaseViewController.h"

@interface TestFunctionVC : TestFunctionBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView *testTableView;
@end


