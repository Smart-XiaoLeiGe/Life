//
//  TestRainVC.m
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestRainVC.h"

@interface RainObject ()

@end
@implementation RainObject
@synthesize time;
@end

@interface TestRainVC ()
{
    NSMutableArray *testRain_ImageViewArray;
}

@end

@implementation TestRainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testRain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testRain
{
    self.view.backgroundColor=[UIColor lightTextColor];
    int rainCount=500;
    testRain_ImageViewArray=[[NSMutableArray alloc] initWithCapacity:50];
    for (int index=1; index<=rainCount; index++) {
        float x=floorf(((double)arc4random() / FM_ARC4RANDOM_MAX) * FM_ScreenWidth/3 + FM_ScreenWidth);
        float y=floorf(((double)arc4random() / FM_ARC4RANDOM_MAX) * FM_ScreenHeight- FM_ScreenHeight);
        NSLog(@"start x:%f  y:%f",x,y);
        RainObject *rainObject=[[RainObject alloc] initWithFrame:CGRectMake(x, y, 6, 18)];
        rainObject.image=[UIImage imageNamed:(index % 2)?@"chart_raindrop1.png":@"chart_raindrop2.png"];
        [testRain_ImageViewArray addObject:rainObject];
        [self.view addSubview:rainObject];
    }
    
    //    [TimerUtil startTimer:self timerTag:@"rain" method:@selector(changeAlpha) withInterval:0.01 repeats:YES];
}

-(void)changeAlpha
{
    int rainSpeed=260;
    //    rainSpeed =arc4random_uniform(300);
    NSMutableArray *imageArray=[[NSMutableArray alloc] initWithCapacity:100];
    for (int index=1; index<=rainSpeed; index++) {
        int value =arc4random_uniform(100);
        [imageArray addObject:[NSNumber numberWithInt:value]];
    }
    //    [imageArray removeAllObjects];
    //    [imageArray addObject:[NSNumber numberWithInt:0]];
    
    for (NSNumber *temp in imageArray) {
        RainObject *imageView=[testRain_ImageViewArray objectAtIndex:[temp intValue]];
        imageView.time+=0.1;
        float juli=0.5*1*pow(imageView.time, 2);
        float angle = atan(3/1);
        float x=juli*cos(angle);
        float y=juli*sin(angle);
        
        [UIView animateWithDuration:0.0 animations:^{
            imageView.frame=CGRectOffset(imageView.frame, -x, y);
            NSLog(@"move x:%f  y:%f",imageView.frame.origin.x,imageView.frame.origin.y);
            if (imageView.frame.origin.x<-imageView.frame.size.width || imageView.frame.origin.y>FM_ScreenHeight) {
                float x=floorf(((double)arc4random() / FM_ARC4RANDOM_MAX) * FM_ScreenWidth/3 + FM_ScreenWidth);
                float y=floorf(((double)arc4random() / FM_ARC4RANDOM_MAX) * FM_ScreenHeight- FM_ScreenHeight);
                NSLog(@"reStart x:%f  y:%f",x,y);
                NSInteger index=[testRain_ImageViewArray indexOfObject:imageView];
                RainObject *imageView1=[[RainObject alloc] initWithFrame:CGRectMake(x, y, 6, 18)];
                imageView1.image=[UIImage imageNamed:(index % 2)?@"chart_raindrop1.png":@"chart_raindrop2.png"];
                [testRain_ImageViewArray addObject:imageView1];
                [self.view addSubview:imageView1];
                [testRain_ImageViewArray removeObject:imageView];
                [imageView removeFromSuperview];
            }
        }];
    }
}


@end
