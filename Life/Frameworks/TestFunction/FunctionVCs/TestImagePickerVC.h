//
//  TestImagePickerVC.h
//  Life
//
//  Created by Devin on 4/21/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestFunctionBaseViewController.h"

@interface TestImagePickerVC : TestFunctionBaseViewController
{
    //输入框
    UITextView *_textEditor;
    
    //下拉菜单
    UIActionSheet *myActionSheet;
    
    //图片2进制路径
    NSString* filePath;
}
@end
