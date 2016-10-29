//
//  TestSimCardVC.m
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestSimCardVC.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface TestSimCardVC ()
{
    CTTelephonyNetworkInfo *networkInfo;
}

@end

@implementation TestSimCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    //当sim卡更换时弹出此窗口
    networkInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carrier){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sim card changed" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    };
    [self printObjectAllProperty:networkInfo];
    [self setAllViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAllViews
{
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
    [self printObjectAllProperty:carrier];
    //应该写在Base里面
    UILabel *readMeLabel = [[UILabel alloc] initWithFrame:FM_ScreenBounds];
    readMeLabel.text = [NSString stringWithFormat:@"%@",carrier];
    readMeLabel.numberOfLines = 0;
    [self.view addSubview:readMeLabel];
}

@end
