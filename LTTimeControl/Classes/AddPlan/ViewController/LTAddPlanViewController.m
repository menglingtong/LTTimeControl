//
//  LTAddPlanViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTAddPlanViewController.h"

#import "LTAddTaskViewController.h"

#import "LTDayHourTableViewCell.h"

#import "LTCoreDataManager.h"

@interface LTAddPlanViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, assign) NSInteger sectionCount;

@property (nonatomic, strong) LTCoreDataManager *ltCoreDataManager;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@property (nonatomic, strong) NSMutableArray *timeDataSourceArr;

@end

@implementation LTAddPlanViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _planTitle;
    
    _timeDataSourceArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 24; i++) {
        
        for (NSInteger j = 0; j < 2; j++) {
            
            if (i < 10 && j == 0) {
                
                NSString *timeStr = [NSString stringWithFormat:@"0%ld : 00", i];
                
                [_timeDataSourceArr addObject:timeStr];
            }
            else if (i < 10 && j == 1)
            {
                NSString *timeStr = [NSString stringWithFormat:@"0%ld : 30", i];
                
                [_timeDataSourceArr addObject:timeStr];
            }
            else if (i >= 10 && j == 0)
            {
                NSString *timeStr = [NSString stringWithFormat:@"%ld : 00", i];
                
                [_timeDataSourceArr addObject:timeStr];
            }
            else if (i >= 10 && j == 1)
            {
                NSString *timeStr = [NSString stringWithFormat:@"%ld : 30", i];
                
                [_timeDataSourceArr addObject:timeStr];
            }
        }
        
    }
    
    // 初始化数据源数组
    _dataSourceArr = [NSMutableArray arrayWithCapacity:0];
    
    // 初始化CoreData管理器
    _ltCoreDataManager = [LTCoreDataManager shareLTCoreDataManager];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedGoBack)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:nil];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - 64) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    
    _mainTableView.dataSource = self;
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mainTableView registerClass:[LTDayHourTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:_mainTableView];
    
    
}

#pragma mark tableView 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 48;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LTDayHourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.timeLabel.text = [_timeDataSourceArr objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTAddTaskViewController *addTaskVC = [LTAddTaskViewController new];
    
    addTaskVC.startTime = [_timeDataSourceArr objectAtIndex:indexPath.row];
    
    if (indexPath.row == _timeDataSourceArr.count) {
        
        addTaskVC.endTime = [_timeDataSourceArr objectAtIndex:0];
    }
    else
    {
        addTaskVC.endTime = [_timeDataSourceArr objectAtIndex:indexPath.row +1];
    }
    
    
    [self.navigationController pushViewController:addTaskVC animated:YES];
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
