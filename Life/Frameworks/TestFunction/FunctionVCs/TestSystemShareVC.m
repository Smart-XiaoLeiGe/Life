//
//  TestSystemShareVC.m
//  Life
//
//  Created by Devin on 5/18/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestSystemShareVC.h"
#import <UIKit/UIActivityViewController.h>
#import "BookActivity.h"

@interface TestSystemShareVC ()

@end

@implementation TestSystemShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton* shareBtn=[[UIButton alloc] initWithFrame:CGRectMake((FM_ScreenWidth-50)/2, 100, 50, 40)];
    [shareBtn setTitle:@"Share" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)shareImage
{
    BookActivity *bookActivity = [BookActivity new];
    NSArray *applicationActivities = @[bookActivity];
    
    UIImage *shareImage = [UIImage imageNamed:@"chuang.png"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://iosshare.cn/"];
    NSArray *activityItems = @[urlToShare,shareImage];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:applicationActivities];
    [activityVC setCompletionWithItemsHandler:^(NSString *type, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        [LogUtil Debug:@"Test System Share" message:[NSString stringWithFormat:@"%@_%@_%@_%@",type,@(completed?1:0),returnedItems,activityError]];
    }];
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook];
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end
