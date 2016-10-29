//
//  TestDrawVC.m
//  Life
//
//  Created by Devin on 3/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestDrawVC.h"

@interface TestDrawVC ()
{
    CGMutablePathRef pathRef;
}
@end

@implementation TestDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawAndCheckPoint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawAndCheckPoint
{
    
    //开始图像绘图
    UIGraphicsBeginImageContext(self.view.bounds.size);
    //获取当前CGContextRef
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建用于转移坐标的Transform，这样我们不用按照实际显示做坐标计算
    CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50);
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    //左眼
    CGPathAddEllipseInRect(path, &transform, CGRectMake(0, 0, 20, 20));
    //右眼
    CGPathAddEllipseInRect(path, &transform, CGRectMake(80, 0, 20, 20));
    //笑
    CGPathMoveToPoint(path, &transform, 100, 50);
    CGPathAddArc(path, &transform, 50, 50, 50, 0, M_PI, NO);
    CGPathCloseSubpath(path);
    //将CGMutablePathRef添加到当前Context内
    CGContextAddPath(gc, path);
    //设置绘图属性
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(gc, 2);
    //执行绘画
    CGContextStrokePath(gc);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:imgView];
    //    pathRef=CGPathCreateMutable();
    //    CGPathMoveToPoint(pathRef, NULL, 4, 4);
    //    CGPathAddLineToPoint(pathRef, NULL, 4, 140);
    //    CGPathAddLineToPoint(pathRef, NULL, 140, 140);
    //    CGPathAddLineToPoint(pathRef, NULL, 140, 4);
    //    CGPathAddLineToPoint(pathRef, NULL, 4, 4);
    //    CGPathCloseSubpath(pathRef);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"point :%@",NSStringFromCGPoint(point));
    if (CGPathContainsPoint(pathRef, NULL, point, NO))
    {
        NSLog(@"point in path!");
    }else
    {
        NSLog(@"outPoint out path!");
    }
}

@end
