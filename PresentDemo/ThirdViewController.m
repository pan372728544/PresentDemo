//
//  ThirdViewController.m
//  PresentDemo
//
//  Created by panzhijun on 2019/3/15.
//  Copyright © 2019 panzhijun. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITableViewDataSourcePrefetching>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-24-10, 10, 24, 24)];
    [btn setBackgroundImage:[UIImage imageNamed:@"close_channel_24x24_"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_W, SCREEN_H-30-STATUSBAR_H) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    
    [self.view addSubview:self.tableView];
    
}

-(void)btnClose:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark --UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"ThirdTest--%ld",indexPath.row];
    return cell;
    
}




#pragma mark --UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 支持多手势
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0)
{
    // 这个方法返回YES，第一个手势和第二个互斥时，第一个会失效
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}

#pragma mark --UIScrollViewDelegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setGestureRecognizerEnable:YES scrollView:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setGestureRecognizerEnable:YES scrollView:scrollView];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // 结束的时候手势可用
    [self setGestureRecognizerEnable:YES scrollView:scrollView];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 滑动到顶部的时候设置手势失效
    if (scrollView.contentOffset.y <=0) {
        
        [self setGestureRecognizerEnable:NO scrollView:scrollView];
    }
    
    else
    {
        // 手势可用
        [self setGestureRecognizerEnable:YES scrollView:scrollView];
    }
}

-(void)setGestureRecognizerEnable:(BOOL)isEnable scrollView:(UIScrollView *)scrollView
{
    for (UIGestureRecognizer *gesRec in  scrollView.gestureRecognizers) {
        if ([gesRec isKindOfClass:[UIPanGestureRecognizer class]]) {
            
            gesRec.enabled =isEnable;
        }
    }
}

@end
