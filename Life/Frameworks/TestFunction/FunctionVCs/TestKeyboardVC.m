//
//  TestKeyboardVC.m
//  Life
//
//  Created by Wang, Devin on 6/28/16.
//  Copyright © 2016 wanglei. All rights reserved.
//

#import "TestKeyboardVC.h"


@interface TestKeyboardVC ()
{
    UITextField *textField;
    NSArray *keyBoardTypes;
}
@end

@implementation TestKeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 30, Width, 40)];
    textField.borderStyle = UITextBorderStyleLine;
    textField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:textField];
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(60, 100, 200, 50) buttonType:BUTTON_NORMAL title:@"Change Type" tag:10001 target:self action:@selector(changeStyle)];
    [self.view addSubview:button];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    keyBoardTypes = @[
                      @"UIKeyboardTypeDefault",
                      @"UIKeyboardTypeASCIICapable",
                      @"UIKeyboardTypeNumbersAndPunctuation",
                      @"UIKeyboardTypeURL",
                      @"UIKeyboardTypeNumberPad",
                      @"UIKeyboardTypePhonePad",
                      @"UIKeyboardTypeNamePhonePad",
                      @"UIKeyboardTypeEmailAddress",
                      @"UIKeyboardTypeDecimalPad",
                      @"UIKeyboardTypeTwitter",
                      @"UIKeyboardTypeWebSearch",
                      ];
    TestSwiftVC *svc = [[TestSwiftVC alloc] init];
    svc.view.frame = CGRectMake(0, 200, 200, 100);
    svc.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:svc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)changeStyle
{
    
    textField.keyboardType += textField.keyboardType<UIKeyboardTypeWebSearch?1:-UIKeyboardTypeWebSearch;
    textField.text = keyBoardTypes[textField.keyboardType];
    [textField resignFirstResponder];
    [textField becomeFirstResponder];
}


- (void)keyboardWillShown:(NSNotification*)aNotification{
    
}


@end
