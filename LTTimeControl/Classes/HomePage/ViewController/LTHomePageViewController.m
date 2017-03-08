//
//  LTHomePageViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTHomePageViewController.h"

#import "LTPlanListViewController.h"

@interface LTHomePageViewController ()

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation LTHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _addBtn.frame = CGRectMake(50 * kWIDTHFIT, 100 * kHEIGHTFIT, 275 * kWIDTHFIT, 30 * kHEIGHTFIT);
    
    [_addBtn setTitle:@"选择每日计划" forState:UIControlStateNormal];
    
    [_addBtn setBackgroundColor:kBUTTONBGCOLOR];
    
    [_addBtn setTitleColor:kBUTTONTITLECOLOR forState:UIControlStateNormal];
    
    _addBtn.layer.cornerRadius = 5.0f;
    
    [_addBtn addTarget:self action:@selector(didClickedAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_addBtn];
    
    
}
- (void)didClickedAddBtn:(UIButton *)sender
{
    LTPlanListViewController *planListVC = [LTPlanListViewController new];
    
    [self.navigationController pushViewController:planListVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
