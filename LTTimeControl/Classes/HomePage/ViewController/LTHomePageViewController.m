//
//  LTHomePageViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTHomePageViewController.h"

@interface LTHomePageViewController ()

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation LTHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _addBtn.frame = CGRectMake(30, 100, 270, 30);
    
    [_addBtn setTitle:@"选择每日计划" forState:UIControlStateNormal];
    
    [_addBtn setBackgroundColor:[UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00]];
    
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _addBtn.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:_addBtn];
    
    
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
