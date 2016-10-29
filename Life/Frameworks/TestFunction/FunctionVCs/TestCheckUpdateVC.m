//
//  TestCheckUpdateVC.m
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestCheckUpdateVC.h"

@interface TestCheckUpdateVC ()

@end

@implementation TestCheckUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self checkAppUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkAppUpdate
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", @"978512367"]];
    NSString * file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSRange substr = [file rangeOfString:@"\"version\":\""];
    NSRange range1 = NSMakeRange(substr.location+substr.length,10);
    if (range1.location == NSNotFound) {
        return;
    }
    NSRange substr2 =[file rangeOfString:@"\"" options:1 range:range1];
    NSRange range2 = NSMakeRange(substr.location+substr.length, substr2.location-substr.location-substr.length);
    NSString *newVersion =[file substringWithRange:range2];
    if(![nowVersion isEqualToString:newVersion])
    {
        [self pushNewVersionVC];
    }
}

-(void)pushNewVersionVC
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Update" message:@"有更新" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
