//
//  ViewController.m
//  PresentDemo
//
//  Created by panzhijun on 2019/3/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"仿头条模态";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIButton *btnPresent = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-200)*0.5, 200, 200, 50)];
    [btnPresent setTitle:@"跳转" forState:UIControlStateNormal];
    [btnPresent addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btnPresent.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:btnPresent];
}

-(void)btnClick
{
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
}

@end
