//
//  LTAddTaskViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/21.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTAddTaskViewController.h"

#import "LTTaskTitleTableViewCell.h"

#import "LTTaskDateTableViewCell.h"

#import "LTDatePicker.h"

@interface LTAddTaskViewController ()<UITableViewDelegate, UITableViewDataSource, LTNSDatePickerDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation LTAddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新建任务";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedGoBack)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - 44) style:UITableViewStyleGrouped];
    
    _mainTableView.delegate = self;
    
    _mainTableView.dataSource = self;
    
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_mainTableView registerClass:[LTTaskTitleTableViewCell class] forCellReuseIdentifier:@"titleCell"];
    [_mainTableView registerClass:[LTTaskDateTableViewCell class] forCellReuseIdentifier:@"dateCell"];
    
    [self.view addSubview:_mainTableView];
    
}

#pragma mark tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.section == 0) {
        
        LTTaskTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        
        cell.taskTitleTextField.placeholder = @"标题";
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        LTTaskDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dateCell"];
        
        if (indexPath.row == 0) {
            
            cell.titleLabel.text = @"开始";
            
            cell.timeLabel.text = _startTime;
        }
        else
        {
            cell.titleLabel.text = @"结束";
            
            cell.timeLabel.text = _endTime;
        }
        
        return cell;
    }
    else
    {
        cell.textLabel.text = @"备注";
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        [self setLtDatePickerInPageWithTime:_startTime];
    }
    else if(indexPath.section == 1 && indexPath.row == 1)
    {
        [self setLtDatePickerInPageWithTime:_endTime];
    }
}

- (void)setLtDatePickerInPageWithTime:(NSString *)time
{
    LTDatePicker *ltDatePicker = [[LTDatePicker alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT - 44, kSCREENWIDTH, 200 * kHEIGHTFIT)];
    
    ltDatePicker.delegate = self;
    
    ltDatePicker.datePickerMode = LTDatePickerModeTimeTwentyFourHalf;
    
    ltDatePicker.hourValue = [[[time componentsSeparatedByString:@" : "] objectAtIndex:0] integerValue];
    
    ltDatePicker.minuteValue = [[[time componentsSeparatedByString:@" : "] objectAtIndex:1] integerValue];
    
    [self.view addSubview:ltDatePicker];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        ltDatePicker.frame = CGRectMake(0, kSCREENHEIGHT - 44 - 200 * kHEIGHTFIT, kSCREENWIDTH, 200 * kHEIGHTFIT);
        
    }];

}

#pragma mark LTDatePicker的代理方法
- (void)confirmActionWithDatePicker:(LTDatePicker *)datePicker WithHintStr:(NSString *)hintStr WithSection:(NSInteger)section WithRow:(NSInteger)row
{
    NSLog(@"%@, %ld, %ld", hintStr, section, row);
}

// 返回上一页
- (void)didClickedGoBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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
