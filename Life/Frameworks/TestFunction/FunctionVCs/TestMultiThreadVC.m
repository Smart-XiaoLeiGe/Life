//
//  TestMultiThreadVC.m
//  Life
//
//  Created by Wang, Devin on 3/13/17.
//  Copyright © 2017 wanglei. All rights reserved.
//

#import "TestMultiThreadVC.h"
#import "MultiThreadManager.h"

#define kTaskNumber 100
@interface TestMultiThreadVC ()
@property (nonatomic, strong) MultiThreadManager *manager;
@property (nonatomic, strong) NSArray *tasks;
@property (nonatomic, strong) TaskBlcok task;
@end

@implementation TestMultiThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [[MultiThreadManager alloc] init];
    self.tasks = [[NSArray alloc] initWithObjects:^(){
        for (NSInteger index = 0; index < kTaskNumber; index++) {
            NSLog(@"task1 %ld",index);
        }
    },^(){
        for (NSInteger index = 0; index < kTaskNumber; index++) {
            NSLog(@"task2 %ld",index);
        }
    }, nil];
    self.task = ^(){
        for (NSInteger index = 0; index < kTaskNumber; index++) {
            NSLog(@"task3 %ld",index);
        }
    };
    [self addButton];
    
}

- (void)addButton{
    UIButton *asyncConcurrent = [UIButton buttonWithType:UIButtonTypeSystem];
    [asyncConcurrent setTitle:@"asyncConcurrent" forState:UIControlStateNormal];
    asyncConcurrent.frame = CGRectMake(10, 100, 150, 80);
    [asyncConcurrent setBackgroundColor:[UIColor yellowColor]];
    [asyncConcurrent addTarget:self action:@selector(asyncConcurrentClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:asyncConcurrent];
}

- (void)asyncConcurrentClick:(UIButton *)button{
    [self.manager performTasks:self.tasks mode:MultiThreadMode_AsyncConcurrent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
