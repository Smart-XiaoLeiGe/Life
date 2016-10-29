//
//  DebugViewController.m
//  Life
//
//  Created by Devin on 1/29/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "DebugViewController.h"
#import "TestFunctionVC.h"

@interface DebugViewController ()
{
    TestFunctionVC *testFunctionVC;
}
@end

@implementation DebugViewController

#pragma mark #ViewController life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.502 alpha:1.000];
    [self initAllViews];
}

-(void)viewWillAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark #Custom view elements layout
-(void)initAllViews
{
    UIButton *hidenBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
    [hidenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hidenBtn setTitle:@"Back" forState:UIControlStateNormal];
    [hidenBtn setTitle:@"Back" forState:UIControlStateSelected];
    [hidenBtn addTarget:self action:@selector(hideDebugView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hidenBtn];
    
    hidenBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, hidenBtn.frame.origin.y+hidenBtn.frame.size.height+10, 160, 60)];
    [hidenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hidenBtn setTitle:@"Send Log" forState:UIControlStateNormal];
    [hidenBtn setTitle:@"Send Log" forState:UIControlStateSelected];
    hidenBtn.backgroundColor=[UIColor orangeColor];
    hidenBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    hidenBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [hidenBtn addTarget:self action:@selector(customSendLog) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hidenBtn];
    
    hidenBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, hidenBtn.frame.origin.y+hidenBtn.frame.size.height+10, 160, 60)];
    [hidenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hidenBtn setTitle:@"Test Function" forState:UIControlStateNormal];
    [hidenBtn setTitle:@"Test Function" forState:UIControlStateSelected];
    hidenBtn.backgroundColor=[UIColor orangeColor];
    hidenBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    hidenBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [hidenBtn addTarget:self action:@selector(customTestFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hidenBtn];
}

#pragma mark #ViewController action

-(void)hideDebugView:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BackDebugPageNotification object:nil];
}

-(void)customTestFunction
{
    testFunctionVC = [[TestFunctionVC alloc] init];
    [self.navigationController pushViewController:testFunctionVC animated:YES];
}

-(void)customSendLog
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = paths[0];
    path = [NSString stringWithFormat:@"%@/%@", path, @"Log"];
    NSDirectoryEnumerator * dirEnum = [fileManager enumeratorAtPath:path];
    NSArray * arr = [dirEnum allObjects];
    
    NSString * latestLogPath = [ arr lastObject];
    NSString * dataFilePath = [NSString stringWithFormat:@"%@/%@", path, latestLogPath];
    NSData * data = [NSData dataWithContentsOfFile:dataFilePath];
    
    //kenny modify start
    //上传倒数第二份日志 如果有
    NSString * beforeLastLogPath = nil;
    NSString * beforeLastFilePath = nil;
    NSData * beforeLastData = nil;
    
    if (arr.count >=2)
    {
        beforeLastLogPath = [arr objectAtIndex:arr.count - 2];
        beforeLastFilePath = [NSString stringWithFormat:@"%@/%@",path, beforeLastLogPath];
        beforeLastData = [NSData dataWithContentsOfFile:beforeLastFilePath];
    }
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        NSString *text = @"FYI";
        [mailViewController setSubject:@"AirTouch日志"];
        [mailViewController setMessageBody:text isHTML:NO];
        [mailViewController setToRecipients:[NSArray arrayWithObject:@"lei.wang9@honeywell.com"]];//
        [mailViewController addAttachmentData:data mimeType:@"text/x-log" fileName:latestLogPath];
        //kenny add
        if (beforeLastLogPath) {
            [mailViewController addAttachmentData:beforeLastData mimeType:@"text/x-log" fileName:beforeLastLogPath];
        }
        [self showMailComposeViewController:mailViewController];
    }
    else
    {
        //        [MessageBox show:@"Please set up your email account"];
    }
}

-(void)sendCocoaLumberjackLog:(NSArray *)addressArray
{
    DDLogFileInfo *logInfo = nil;
    for (id <DDLogger> logger in [DDLog allLoggers]) {
        if ([logger isKindOfClass:[DDFileLogger class]]) {
            logInfo = [(DDFileLogger *)logger currentLogFileInfo];
        }
    }
    
    NSData* data = [NSData dataWithContentsOfFile:logInfo.filePath];
    
    //kenny modify end
    
    //if是在真机运行
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;

        //设备相关信息的获取
        NSString *strName = [[UIDevice currentDevice] name];  //e.g. "My iPhone"
        NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];  // e.g. @"4.0"
        NSString *strModel = [[UIDevice currentDevice] model];  // e.g. @"iPhone", @"iPod touch"
        NSString* phoneModel = [[UIDevice currentDevice] model];   //手机型号
        //app应用相关信息的获取
        NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
        NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];  // 当前应用名称
        NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
        // 当前应用软件版本  比如：1.0.1
        
        [mailViewController setSubject: @"客户端反馈"];
        [mailViewController setMessageBody:[NSString stringWithFormat:@"设备名称：%@ \n系统版本号：%@\n设备模式：%@\n手机型号: %@\nApp应用名称：%@\nApp应用版本：%@\n",strName,strSysVersion,strModel,phoneModel,strAppName,strAppVersion] isHTML:NO];
        [mailViewController setToRecipients:[NSArray arrayWithObject:@"lei.wang9@honeywell.com"]];//
        [mailViewController addAttachmentData:data mimeType:@"text/x-log" fileName:logInfo.fileName];
        
        [self showMailComposeViewController:mailViewController];
    }
    else
    {
//        [MessageBox show:@"Please set up your email account"];
    }
}

- (void)showMailComposeViewController:(MFMailComposeViewController *)mvc
{
    [self presentViewController:mvc animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
