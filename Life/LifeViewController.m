//
//  LifeViewController.m
//  Life
//
//  Created by Devin on 1/24/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "LifeViewController.h"
#import "DebugManager.h"

@interface LifeViewController ()
{
    NSString *appUrl;
    DebugManager *debugManager;
}
@end

@implementation LifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDebugPage];
    [self registerNotification];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self checkUpdate];
}

-(void)testS
{
    //    NSString *s = @"This is a test string";
    //    s =[s substringWithRange:NSMakeRange(3, [s length])];
    //    NSLog(@"%@",s);

    NSArray *array = @[@"",@""];
    [LogUtil Debug:@"testCrash" message:array[2]];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(catchCrash:) name:kCrashNotification object:nil];
}

-(void)catchCrash:(NSNotification *)note
{
    [LogManager debug:@"Crash" log:note.object];
}

-(void)initDebugPage
{
    debugManager = [[DebugManager alloc] init];
    [debugManager setDebugManager:self withDebugPageBlock:^{
    } hideBlock:^{
            [self testS];
    } gestureAction:@selector(doGesture:)];
}

-(void)doGesture:(UILongPressGestureRecognizer *)gesture
{
    [debugManager debugGestureAction:gesture];
}

-(void)checkUpdate
{
    [UMengsManager checkUpdate:^(BOOL isForceUpdate, NSString *updateString,NSString *appPath) {
        UIAlertView *forceAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"App_AutoUpdate_AlertTitle", nil) message:updateString delegate:self cancelButtonTitle:(isForceUpdate?nil:NSLocalizedString(@"App_AutoUpdate_AlertSkip", nil)) otherButtonTitles:NSLocalizedString(@"App_AutoUpdate_AlertUpdate", nil), nil];
        appUrl=appPath;
        [forceAlertView show];
    }];
}

#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView numberOfButtons]==1 || ([alertView numberOfButtons]==2 && buttonIndex==1)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
    }else
    {
        //七日后再次提示
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
