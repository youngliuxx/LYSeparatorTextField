//
//  ViewController.m
//  SeparatorTextField
//
//  Created by youngliuxx on 13/12/2017.
//  Copyright © 2017 youngliuxx. All rights reserved.
//

#import "ViewController.h"
#import "LYSeparatorTextField.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface ViewController ()

@property (nonatomic, strong) LYSeparatorTextField *textField;
@property (nonatomic, strong) LYSeparatorTextField *textField2;
@property (nonatomic, strong) LYSeparatorTextField *textField3;
@property (nonatomic, strong) LYSeparatorTextField *textField4;
@property (nonatomic, strong) LYSeparatorTextField *textField5;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews
{
    CGFloat space = 20.0;
    
    // 12345-123456
    _textField = [[LYSeparatorTextField alloc] initWithFrame:CGRectMake(space, 100, SCREEN_WIDTH - space*2, 30)
                                                   gapNumber:4
                                                   separator:@"-"];
    _textField.placeholder = @"separator: -";
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.limitCount = 12;
    [self.view addSubview:_textField];
    
    // 123,234
    _textField2 = [[LYSeparatorTextField alloc] initWithFrame:CGRectMake(space, 160, SCREEN_WIDTH - space*2, 30)
                                                   gapNumber:3
                                                   separator:@","];
    _textField2.placeholder = @"separator: ,";
    [self.view addSubview:_textField2];
    
    // xxxx-xx-xx
    _textField3 = [[LYSeparatorTextField alloc] initWithFrame:CGRectMake(space, 220, SCREEN_WIDTH - space*2, 30) format:@"^^^^-^^-^^"];
    _textField3.placeholder = @"format: xxxx-xx-xx";
    _textField3.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_textField3];
    
    // Day:01 Month:01 Year:2017
    _textField4 = [[LYSeparatorTextField alloc] initWithFrame:CGRectMake(space, 280, SCREEN_WIDTH - space*2, 30) format:@"Day:^^ Month:^^ Year:^^^^"];
    _textField4.placeholder = @"format: Day:^^ Month:^^ Year:^^^^";
    _textField4.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_textField4];
    
    // Day:01 Month:01 Year:2017
    _textField5 = [[LYSeparatorTextField alloc] initWithFrame:CGRectMake(space, 340, SCREEN_WIDTH - space*2, 30) format:@"^^^-^^^^-^^^^"];
    _textField5.placeholder = @"format: 185-0000-0001";
    _textField5.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_textField5];
    
    _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(space, 560, SCREEN_WIDTH - space*2, 40)];
    [_submitBtn setBackgroundColor:[UIColor grayColor]];
    [_submitBtn setTitle:@"Print Input Text" forState:UIControlStateNormal];
    [self.view addSubview:_submitBtn];
    [_submitBtn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer *)tap{
    [_textField resignFirstResponder];
    [_textField2 resignFirstResponder];
    [_textField3 resignFirstResponder];
    [_textField4 resignFirstResponder];
    [_textField5 resignFirstResponder];
}

- (void)tapBtn:(id)sender
{
    NSLog(@"Input text:%@", _textField.getInputText);
    NSLog(@"Input text:%@", _textField2.getInputText);
    NSLog(@"Input text:%@", _textField3.getInputText);
    NSLog(@"Input text:%@", _textField4.getInputText);
    NSLog(@"Input text:%@", _textField5.getInputText);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
