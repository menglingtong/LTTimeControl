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

@property (nonatomic, strong) LTDatePicker *ltDatePicker;

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
        
        [self setLtDatePickerInPageWithTime:_startTime andSection:indexPath.section andRow:indexPath.row];
    }
    else if(indexPath.section == 1 && indexPath.row == 1)
    {
        [self setLtDatePickerInPageWithTime:_endTime andSection:indexPath.section andRow:indexPath.row];
    }
}

- (void)setLtDatePickerInPageWithTime:(NSString *)time andSection:(NSInteger)section andRow:(NSInteger)row
{
    [_ltDatePicker removeFromSuperview];
    
    _ltDatePicker  = [[LTDatePicker alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT - 44, kSCREENWIDTH, 200 * kHEIGHTFIT)];
    
    _ltDatePicker.delegate       = self;
    
    _ltDatePicker.sectionNum     = section;
    
    _ltDatePicker.rowNum         = row;
    
    _ltDatePicker.datePickerMode = LTDatePickerModeTimeTwentyFourHalf;
    
    NSInteger hour              = [[[time componentsSeparatedByString:@" : "] objectAtIndex:0] integerValue];
    
    NSInteger minute            = [[[time componentsSeparatedByString:@" : "] objectAtIndex:1] integerValue];
    
    _ltDatePicker.hourValue      = hour;
    
    _ltDatePicker.minuteValue    = minute;
    
    [self.view addSubview:_ltDatePicker];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _ltDatePicker.frame = CGRectMake(0, kSCREENHEIGHT - 44 - 200 * kHEIGHTFIT, kSCREENWIDTH, 200 * kHEIGHTFIT);
        
    }];

}

#pragma mark LTDatePicker的代理方法
- (void)confirmActionWithDatePicker:(LTDatePicker *)datePicker WithHintStr:(NSString *)hintStr WithSection:(NSInteger)section WithRow:(NSInteger)row
{
    
    LTTaskDateTableViewCell *cell = [_mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    
    cell.timeLabel.text = hintStr;
    
    if (section == 1 && row == 0) {
        
        _startTime = hintStr;
    }
    else if(section == 1 && row == 1)
    {
        _endTime = hintStr;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [datePicker removeFromSuperview];
        
    });
    
    
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
