//
//  ViewController.m
//  PresentDemo
//
//  Created by panzhijun on 2019/3/13.
//  Copyright © 2019 panzhijun. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"The";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIButton *btnPresent = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-300)*0.5, 200, 300, 50)];
    [btnPresent setTitle:@"跳转-支持下拉和➡️滑返回" forState:UIControlStateNormal];
    [btnPresent addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btnPresent.backgroundColor = [UIColor orangeColor];

    [self.view addSubview:btnPresent];
    
    
    
    
    UIButton *btnPresent2 = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-300)*0.5, 300, 300, 50)];
    [btnPresent2 setTitle:@"跳转-只支持下拉" forState:UIControlStateNormal];
    [btnPresent2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    btnPresent2.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:btnPresent2];
    

}

-(void)btnClick
{
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
}

-(void)btnClick2
{
    [self presentViewController:[ThirdViewController new] animated:YES completion:nil];
}

@end
