//
//  LTBaseViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"

@interface LTBaseViewController ()

@end

@implementation LTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barTintColor = kNAVBACKGROUNDCOLOR;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self; // 自定义返回按钮后，边缘返回手势失效，使边缘手势生效
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    [self.navigationItem setTitle:@"Time Control"];
    
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
