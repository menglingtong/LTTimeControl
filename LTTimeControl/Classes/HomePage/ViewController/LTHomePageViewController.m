//
//  LTHomePageViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/27.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTHomePageViewController.h"

#import "LTPlanListViewController.h"

#import "LTCoreDataManager.h"

#import "Plan.h"

#import "Task.h"

#import "LTHomeTaskTableViewCell.h"

@interface LTHomePageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) LTCoreDataManager *ltCoreDataManager;

@property (nonatomic, strong) NSArray *dataSourceArr;

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation LTHomePageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadDataSourceArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"计划列表" style:UIBarButtonItemStylePlain target:self action:@selector(didClickedAddBtn:)];
    
    _ltCoreDataManager = [LTCoreDataManager shareLTCoreDataManager];
    
    [self selectPlanByIsOn];
    
    
}

- (void)selectPlanByIsOn
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityPlan = [NSEntityDescription entityForName:@"Plan" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
    
    [fetchRequest setEntity:entityPlan];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isOn = 1"];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *fetchPlanArry = [_ltCoreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    if (fetchPlanArry && [fetchPlanArry count] > 0) {
        
        Plan *planObj = [fetchPlanArry firstObject];
        
        NSLog(@"%ld", [planObj.planId integerValue]);
        
        NSFetchRequest *fetchPlanRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityTask = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
        
        [fetchPlanRequest setEntity:entityTask];
        
        NSPredicate *predicateTask = [NSPredicate predicateWithFormat:@"planId = %ld", [planObj.planId integerValue]];
        
        [fetchPlanRequest setPredicate:predicateTask];
        
        NSArray *fetchTaskArray = [_ltCoreDataManager.managedObjectContext executeFetchRequest:fetchPlanRequest error:&error];
        
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (fetchTaskArray && [fetchTaskArray count] > 0) {
            
            _dataSourceArr = [fetchTaskArray mutableCopy];
            
            [self setMainTableViewByAddingTable];
        }
        else
        {
            [self setBlankPageByAddingButton];
        }
        
    }
    else
    {
        [self setBlankPageByAddingButton];
    }
    
}

#pragma mark 刷新数据源数组
- (void)reloadDataSourceArray
{
    _dataSourceArr = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityPlan = [NSEntityDescription entityForName:@"Plan" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
    
    [fetchRequest setEntity:entityPlan];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isOn = 1"];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *fetchPlanArry = [_ltCoreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    if (fetchPlanArry && [fetchPlanArry count] > 0) {
        
        Plan *planObj = [fetchPlanArry firstObject];
        
        NSLog(@"%ld", [planObj.planId integerValue]);
        
        NSFetchRequest *fetchPlanRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityTask = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
        
        [fetchPlanRequest setEntity:entityTask];
        
        NSPredicate *predicateTask = [NSPredicate predicateWithFormat:@"planId = %ld", [planObj.planId integerValue]];
        
        [fetchPlanRequest setPredicate:predicateTask];
        
        NSArray *fetchTaskArray = [_ltCoreDataManager.managedObjectContext executeFetchRequest:fetchPlanRequest error:&error];
        
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (fetchTaskArray && [fetchTaskArray count] > 0) {
            
            _dataSourceArr = [fetchTaskArray mutableCopy];
            
            [_mainTableView reloadData];
        }
        
    }
    else
    {
        [_mainTableView removeFromSuperview];
        
        [self setBlankPageByAddingButton];
    }
    
}

#pragma mark 添加按钮
- (void)setBlankPageByAddingButton
{
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _addBtn.frame = CGRectMake(50 * kWIDTHFIT, 100 * kHEIGHTFIT, 275 * kWIDTHFIT, 30 * kHEIGHTFIT);
    
    [_addBtn setTitle:@"选择每日计划" forState:UIControlStateNormal];
    
    [_addBtn setBackgroundColor:kBUTTONBGCOLOR];
    
    [_addBtn setTitleColor:kBUTTONTITLECOLOR forState:UIControlStateNormal];
    
    _addBtn.layer.cornerRadius = 5.0f;
    
    [_addBtn addTarget:self action:@selector(didClickedAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_addBtn];
}

#pragma mark 添加列表
- (void)setMainTableViewByAddingTable
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - 44) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    
    _mainTableView.dataSource = self;
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mainTableView registerClass:[LTHomeTaskTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_mainTableView];
}

#pragma mark tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTHomeTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Task *taskObj = [_dataSourceArr objectAtIndex:indexPath.row];
    
    cell.timeLabel.text = taskObj.startTime;
    
    cell.taskNameLabel.text = taskObj.taskName;
    
    return cell;
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
