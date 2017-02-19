//
//  TestFunctionBaseViewController.m
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestFunctionBaseViewController.h"

@interface TestFunctionBaseViewController ()
{
    UIView *navigationBarView ;
    UIView *bottomBarView ;
    UIView *contentView ;
}

@end

@implementation TestFunctionBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setView
{
    self.view.backgroundColor = [UIColor whiteColor];
    navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, FM_ScreenWidth, 40)];
    UIButton* closeViewBtn=[[UIButton alloc] initWithFrame:CGRectMake(FM_ScreenWidth- 60, 20, 50, 40)];
    [closeViewBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeViewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeViewBtn addTarget:self action:@selector(closeTestFunctionVC) forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:closeViewBtn];
    [self.view addSubview:navigationBarView];
    navigationBarView.backgroundColor = [UIColor lightTextColor];
    
//    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, FM_ScreenHeight-60, FM_ScreenWidth, FM_ScreenHeight-100)];
//    [self.view addSubview:contentView];
//    contentView.backgroundColor = [UIColor greenColor];
//    
//    bottomBarView = [[UIView alloc] initWithFrame:CGRectMake(0, FM_ScreenHeight-40, FM_ScreenWidth, 40)];
//    bottomBarView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:bottomBarView];
}

-(void)closeTestFunctionVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)printObjectAllProperty:(id)object
{
    NSString* className=NSStringFromClass([object class]);
    unsigned int count = 0;
    objc_property_t * properties = class_copyPropertyList(NSClassFromString(className), &count);
    
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        const char * c = property_getName(property);
        const char * attributes = property_getAttributes(property);
        NSString * propertyName = [NSString stringWithUTF8String:c];
        NSString * propertyType = [NSString stringWithUTF8String:attributes];
        //        if ([propertyType isEqualToString:@"NSString"]) {
        //            [testObj setValue:[NSString stringWithFormat:@"%@_%@",propertyName,propertyType] forKey:propertyName];
        //        }
        [LogUtil Debug:[NSString stringWithFormat:@"%@",className] message:[NSString stringWithFormat:@"%@_%@_%@",propertyName,propertyType,[object valueForKey:propertyName]]];
    }
}

@end
