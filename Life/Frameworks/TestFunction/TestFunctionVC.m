//
//  TestFunctionVC.m
//  Life
//
//  Created by Devin on 10/29/15.
//  Copyright (c) 2015 wanglei. All rights reserved.
//

#import "TestFunctionVC.h"
@interface TestFunctionVC ()
{
    NSArray *imagesArray;
    NSInteger repeatCount;
    
    NSArray * titlesArray;
    NSArray * sectionTitlesArray;
    
    UIView *subContentView;
    NSArray *timerArray;
    
}
@end


@implementation TestFunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.disableGesture = YES;
    timerArray=[[NSArray alloc] initWithObjects:@"changeImage",@"rain", nil];
    titlesArray=@[
                  @[@[@"draw",@"TestDrawVC"],
                    @[@"fingerPrint",@"TestFingerPrintVC"],
                    @[@"rain",@"TestRainVC"],
                    @[@"checkUpdate",@"TestCheckUpdateVC"],
                    @[@"systemEvent",@"TestSystemEventVC"],
                    @[@"playMusic",@"TestPlayMusicVC"],
                    @[@"coreSpotlight",@"TestCoreSpotlightVC"],
                    @[@"Sim",@"TestSimCardVC"],
                    @[@"NSLocale",@"TestNSLocaleVC"],
                    @[@"ImagePicker",@"TestImagePickerVC"],
                    @[@"Objective-c 基础",@"TestObjectiveCVC"],
                    @[@"CoreBluetooth",@"TestCoreBluetoothVC"],
                    @[@"MultiThread",@"TestMultiThreadVC"],
                    ]];
    sectionTitlesArray=@[@"Demo",@"API"];
    _testTableView=[[UITableView alloc] initWithFrame:FM_ScreenBounds];
    _testTableView.delegate=self;
    _testTableView.dataSource=self;
    [self.view insertSubview:_testTableView atIndex:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titlesArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitlesArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[titlesArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"testDemoIndentifier"];
    cell.backgroundColor = [UIColor lightTextColor];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testDemoIndentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        [cell.textLabel setTextColor:[UIColor blueColor]];
    }
    
    [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    [cell.textLabel setText:titlesArray[indexPath.section][indexPath.row][0]];
    
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self pushSubVC:titlesArray[indexPath.section][indexPath.row][1]];
}

-(void)pushSubVC:(NSString *)vcClassName
{
    Class targetClass = NSClassFromString(vcClassName);
    UIViewController* targetVC = [[targetClass alloc] init];
    [self.navigationController pushViewController:targetVC animated:YES];
}

@end
