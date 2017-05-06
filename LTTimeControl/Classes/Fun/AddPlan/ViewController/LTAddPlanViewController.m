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

#import "LTTaskWithOrderModel.h"

#import "Task.h"

#import "Plan.h"

#import "LTCoreDataManager.h"

@interface LTAddPlanViewController ()<UITableViewDelegate, UITableViewDataSource, LTAddTaskDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, assign) NSInteger sectionCount;

@property (nonatomic, strong) LTCoreDataManager *ltCoreDataManager;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@property (nonatomic, strong) NSMutableArray *timeDataSourceArr;

@property (nonatomic, strong) NSMutableArray *taskSourceArr;

@property (nonatomic, strong) UIColor *bgColor;

@end

@implementation LTAddPlanViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _planTitle;
    
    _timeDataSourceArr = [NSMutableArray array];
    
    _taskSourceArr = [NSMutableArray array];
    
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didClickedSaveBtn:)];
    
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
    LTAddTaskViewController *addTaskVC  = [LTAddTaskViewController new];
    
    addTaskVC.delegate                  = self;
    
    addTaskVC.planId                    = _planId;
    
    addTaskVC.startTime                 = [_timeDataSourceArr objectAtIndex:indexPath.row];
    
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

#pragma mark 添加Task代理方法
- (void)saveTaskWithTaskName:(NSString *)taskName andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andBgColor:(UIColor *)bgColor
{
    NSLog(@"任务名称：%@, 开始时间：%@, 结束时间：%@", taskName, startTime, endTime);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:taskName, @"taskName", startTime, @"startTime", endTime, @"endTime", nil];
    
    LTTaskWithOrderModel *taskModel = [[LTTaskWithOrderModel alloc] initWithStartTime:startTime andEndTime:endTime andTaskName:taskName];
    
    taskModel.timeDataSourceArr = [_timeDataSourceArr copy];
    
    [_taskSourceArr addObject:taskModel];
    
    _bgColor = bgColor;
    
    NSLog(@"%ld", _taskSourceArr.count);
    
    [self drawTaskInPageWithTaskDic:dic];
    
}

#pragma mark 根据添加的task 绘制页面
- (void)drawTaskInPageWithTaskDic:(NSDictionary *)taskDic
{
    
    NSInteger startIndex = [_timeDataSourceArr indexOfObject:[taskDic objectForKey:@"startTime"]];
    
    NSInteger endIndex   = [_timeDataSourceArr indexOfObject:[taskDic objectForKey:@"endTime"]];
    
    CGRect viewFrame = CGRectMake(0, 60 * startIndex, kSCREENWIDTH, (endIndex - startIndex) * 60);
    
    UIView *view = [[UIView alloc] initWithFrame:viewFrame];
    
    view.backgroundColor = _bgColor;
    
    [_mainTableView addSubview:view];
    
    UILabel *taskNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, (endIndex - startIndex) * 60)];
    
    taskNameLabel.text = [taskDic objectForKey:@"taskName"];
    
    taskNameLabel.textAlignment = 1;
    
    taskNameLabel.textColor = [UIColor colorWithRed:0.86 green:0.32 blue:0.29 alpha:1.00];
    
    [view addSubview:taskNameLabel];
    
    NSLog(@"开始排序 %ld， 结束排序 %ld", startIndex, endIndex);
    
}

#pragma mark 保存整个Plan
- (void)didClickedSaveBtn:(UIButton *)sender
{
    NSLog(@"有%ld个task，planId 是 %ld, PlanName为%@", _taskSourceArr.count, _planId, _planTitle);
    
    [self savePlan];
}

#pragma mark 保存plan方法
- (void)savePlan
{
    
    Plan *planObj = [self getPlanInfoById:_planId];
    
    if (planObj == nil) {
        planObj = [NSEntityDescription insertNewObjectForEntityForName:@"Plan" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
    }
    
    if (![self isBlankString:_planTitle]) {
        
        // 调用保存任务方法
        if ([self saveTask]) {
            
            // 保存计划id
            planObj.planId = [NSNumber numberWithInteger:_planId];
            
            // 保存计划名称
            planObj.planName = _planTitle;
            
            NSLog(@"%@", planObj.planName);
            
            [_ltCoreDataManager saveContext];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            NSLog(@"保存失败");
        }
        
    }
    
    planObj = nil;
}

#pragma mark 根据id查询对应的plan信息
- (Plan *)getPlanInfoById:(NSInteger)planId
{
    Plan *planObj = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Plan" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
    
    [fetchRequest setFetchLimit:1];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"planId == %ld", planId];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *fetchObjArr = [_ltCoreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    if (fetchObjArr && [fetchObjArr count] > 0) {
        
        planObj = [fetchObjArr objectAtIndex:0];
        
    }
    
    fetchRequest = nil;
    
    return planObj;
    
}

#pragma mark 保存task方法
- (BOOL)saveTask
{
    NSArray *newTaskArr = [_taskSourceArr sortedArrayUsingSelector:@selector(compareWithStartTime:)];
    
    if ([_taskSourceArr count] > 0) {
        
        for (NSInteger i = 0; i < newTaskArr.count; i++) {
            
            Task *taskObj = [self getTaskInfoById:i andPlanId:_planId];
            
            if (taskObj == nil) {
                
                taskObj = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
            }
            
            
            taskObj.planId = [NSNumber numberWithInteger:_planId];
            
            taskObj.planName = _planTitle;
            
            taskObj.startTime = [[newTaskArr objectAtIndex:i] startTime];
            
            taskObj.endTime = [[newTaskArr objectAtIndex:i] endTime];
            
            taskObj.taskName = [[newTaskArr objectAtIndex:i] taskName];
            
            taskObj.taskId = [NSNumber numberWithInteger:i];
            
            NSError *error = nil;
            
            if (_ltCoreDataManager.managedObjectContext.hasChanges) {
                
                [_ltCoreDataManager.managedObjectContext save:&error];
            }
            
            if (error) {
                
                NSLog(@"CoreData Insert Data Error : %@", error);
            }
            
        }
        
        return YES;
    }
    else
    {
        NSLog(@"没有任务可保存");
        
        return NO;
    }
    
}

#pragma mark 根据id查询对应task信息
- (Task *)getTaskInfoById:(NSInteger)taskId andPlanId:(NSInteger)planId
{
    Task *taskObj = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity  = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    // 设置查询条件
    // taskId 是否存在
    NSPredicate *predicateTaskId = [NSPredicate predicateWithFormat:@"taskId == %ld", taskId];
    // planId 是否存在
    NSPredicate *predicatePlanId = [NSPredicate predicateWithFormat:@"planId == %ld", planId];
    
    NSCompoundPredicate *compoundPredicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:@[predicatePlanId, predicateTaskId]];
    
    [fetchRequest setPredicate:compoundPredicate];
    // 设置最多条目
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    
    NSArray *fetchObjArr = [_ltCoreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    if (fetchObjArr && [fetchObjArr count] > 0) {
        
        taskObj = [fetchObjArr objectAtIndex:0];
        
    }
    
    fetchRequest = nil;
    
    return taskObj;
    
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
