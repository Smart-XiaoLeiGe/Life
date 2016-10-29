//
//  TestCoreSpotlightVC.m
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestCoreSpotlightVC.h"
#import <CoreSpotlight/CoreSpotlight.h>

@interface TestCoreSpotlightVC ()

@end

@implementation TestCoreSpotlightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testCoreSpotlight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  引入Framework，生成数据，appdelegate 执行点击后的后续自定义操作
 */
-(void)testCoreSpotlight
{
    UILabel * readMeLabel = [[UILabel alloc] init];
    readMeLabel.text = @"去系统搜索处 搜做1，2 或者3";
    NSMutableArray *seachableItems = [NSMutableArray new];
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    for (NSString *string in dataArray) {
        CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"views"];
        //        attributeSet.
        attributeSet.title = string;
        attributeSet.contentDescription = [NSString stringWithFormat:NSLocalizedString(@"a easy way\n to open %@", nil),string];
        UIImage *thumbImage = [UIImage imageNamed:[NSString stringWithFormat:@"icon_%@.png",string]];
        attributeSet.thumbnailData = UIImagePNGRepresentation(thumbImage);//beta 1 there is a bug
        CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:string                                                                                                                                    domainIdentifier:([string isEqualToString:@"1"]?@"com.honeywell.airtouchtest":@"com.honeywell.airtouchtestTDD")                                                                                                        attributeSet:attributeSet];
        [seachableItems addObject:item];
        
    }
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:seachableItems
                                                   completionHandler:^(NSError * __nullable error) {                                                              if (error)
                                                       [LogUtil Debug:@"Spotlight" message:error.localizedDescription];
                                                   else
                                                       [LogUtil Debug:@"Spotlight" message:@"happy"];
                                                   }];
    CSSearchableItemAttributeSet *testObj = (CSSearchableItemAttributeSet *)[self initObjectAllProperty:@"CSSearchableItemAttributeSet"];
    [LogUtil Debug:@"Spotlight" message:testObj.title];
}

-(id)initObjectAllProperty:(NSString *)className
{
    id testObj=[[NSClassFromString(className) alloc] init];
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
        [LogUtil Debug:@"Spotlight" message:[NSString stringWithFormat:@"%@_%@",propertyName,propertyType]];
    }
    return testObj;
}

@end
