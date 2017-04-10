//
//  LTAddPlanViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTAddPlanViewController.h"

#import "LTPlanTitleTableViewCell.h"

#import "LTAddPlanSectionFooterView.h"

#import "LTTaskButtonTableViewCell.h"

#import "LTTimePickerTableViewCell.h"

#import "LTDatePicker.h"

#import "UIView+LTKeyboardOffsetView.h"

#import "Task.h"

#import "Plan.h"

#import "LTCoreDataManager.h"

@interface LTAddPlanViewController ()<UITableViewDelegate, UITableViewDataSource, LTNSDatePickerDelegate, LTKeyboardOffsetViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) LTDatePicker *timePiker;

@property (nonatomic, assign) NSInteger sectionCount;

@property (nonatomic, strong) LTCoreDataManager *ltCoreDataManager;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation LTAddPlanViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view openKeyboardOffsetView];
    
    self.view.ltKeyboardOffsetViewDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view closeKeyboardOffsetView];
}

/**
 *  弹出键盘时，自定义视图向上移动的高度
 *
 *  @param firstResponder 第一响应者
 *  @param keyboardHeight 当前弹出键盘的高度
 *  @param offsetHeight   默认偏移高度
 *
 *  @return 视图向上移动的高度
 */
- (CGFloat)offsetHeightWithFirstResponder:(UIView *)firstResponder keyboardHeight:(CGFloat)keyboardHeight offsetHeight:(CGFloat)offsetHeight
{
//    if ([firstResponder isEqual:_testTextField])
//    {
//        return keyboardHeight;
//    }
    return offsetHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _planTitle;
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
//    [self.view addGestureRecognizer:tapGesture];
    
    // 初始化数据源数组
    _dataSourceArr = [NSMutableArray arrayWithCapacity:0];
    
    // 初始化CoreData管理器
    _ltCoreDataManager = [LTCoreDataManager shareLTCoreDataManager];
    
    // 默认1个分区
    _sectionCount = 1;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedGoBack)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savePlan)];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - 64) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    
    _mainTableView.dataSource = self;
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 标题cell
    [_mainTableView registerClass:[LTPlanTitleTableViewCell class] forCellReuseIdentifier:@"titleCell"];
    // 按钮cell
    [_mainTableView registerClass:[LTTaskButtonTableViewCell class] forCellReuseIdentifier:@"buttonCell"];
    // pickerCell
    [_mainTableView registerClass:[LTTimePickerTableViewCell class] forCellReuseIdentifier:@"pickerCell"];
    // footerView
    [_mainTableView registerClass:[LTAddPlanSectionFooterView class] forHeaderFooterViewReuseIdentifier:@"footerView"];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 130 * kHEIGHTFIT)];
    
    UIButton *addSectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addSectionBtn.frame = CGRectMake(50 * kWIDTHFIT, 50 * kHEIGHTFIT, 275 * kWIDTHFIT, 30 * kHEIGHTFIT);
    
    [addSectionBtn setTitle:@"添加任务" forState:UIControlStateNormal];
    
    addSectionBtn.layer.cornerRadius = kCORNERRADIUS;
    
    [addSectionBtn setBackgroundColor:kBUTTONBGCOLOR];
    
    [addSectionBtn setTitleColor:kBUTTONTITLECOLOR forState:UIControlStateNormal];
    
    [addSectionBtn addTarget:self action:@selector(didClickedAddSection) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:addSectionBtn];
    
    _mainTableView.tableFooterView = footerView;
    
    [self.view addSubview:_mainTableView];
    
//    [self putPickerView];
    
}

// 点击屏幕收起键盘
- (void)tapGesture{
    
    [self.view endEditing:YES];
    
}

- (void)putPickerViewWithSectionNum:(NSInteger)sectionNum RowNum:(NSInteger)rowNum {
    
    _timePiker = [[LTDatePicker alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT, kSCREENWIDTH, 200 * kHEIGHTFIT)];
    
    _timePiker.delegate = self;
    
    _timePiker.sectionNum = sectionNum;
    
    _timePiker.rowNum = rowNum;
    
    [self.view addSubview:_timePiker];
    
//    __weak LTAddPlanViewController *weakSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _timePiker.frame = CGRectMake(0, kSCREENHEIGHT - 200 * kHEIGHTFIT - 64, kSCREENWIDTH, 200 * kHEIGHTFIT);
        
    }];
    
    
    
}

/**
 *  datePicker确认按钮代理方法
 *
 *  @param datePicker datePicker对象
 *  @param hintStr    时间字符串
 *  @param section    分区号
 *  @param row        行号
 */
- (void)confirmActionWithDatePicker:(LTDatePicker *)datePicker WithHintStr:(NSString *)hintStr WithSection:(NSInteger)section WithRow:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    LTTimePickerTableViewCell *cell = [_mainTableView cellForRowAtIndexPath:indexPath];
    
    cell.timeLabel.text = hintStr;
    
}

#pragma mark tableView 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4.5f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    LTAddPlanSectionFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerView"];
    
    return footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        
    return _sectionCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        
        LTPlanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        
        cell.planTitleLabel.text = @"任务名称：";
        
        NSLog(@"数据原数组中的数据数量：%ld", _dataSourceArr.count);
        
        // 判断该分区是否有数据
        if (_dataSourceArr.count != 0 && _dataSourceArr.count > indexPath.section) {
            
            Task *taskObj = [_dataSourceArr objectAtIndex:indexPath.section];
            
            cell.planTitleTextField.text = taskObj.taskName;
            
        }
        else
        {
            cell.planTitleTextField.placeholder = @"请输入任务名称";
        }
        
        return cell;
        
    }
    else if(indexPath.row == 3)
    {
        LTTaskButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
        
        cell.sectionNum = indexPath.section;
        
        cell.deleteBlock = ^(NSInteger sectionNum){
            
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:sectionNum];
            
            if (_sectionCount > 1) {
                
                _sectionCount -= 1;
                
                [_mainTableView deleteSections:set withRowAnimation:UITableViewRowAnimationFade];
                
                // 延迟0.3秒执行刷新tableview，实现动画完整性
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [_mainTableView reloadData];
                    
                });
                
                // 点击删除，执行删除
                [self deleteTaskWithTaskId:indexPath.section andPlanId:1];
                
            }
            
        };
#pragma mark 保存按钮block
        cell.confirmBlock = ^(NSInteger sectionNum){
            NSLog(@"%ld", sectionNum);
            [self saveSectionWithSectionNum:sectionNum];
            
        };
        
        return cell;
        
    }else if (indexPath.row == 1)
    {
        LTTimePickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pickerCell"];
        
        cell.planTitleLabel.text = @"开始时间：";
        
        NSLog(@"数据原数组中的数据数量：%ld", _dataSourceArr.count);
        
        // 判断该分区是否有数据
        if (_dataSourceArr.count != 0 && _dataSourceArr.count > indexPath.section) {
            
            Task *taskObj = [_dataSourceArr objectAtIndex:indexPath.section];
            
            cell.timeLabel.text = taskObj.startTime;
            
        }
        else
        {
            cell.timeLabel.text = @"请选择开始时间";
        }
        
        return cell;
    }else if (indexPath.row == 2)
    {
        LTTimePickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pickerCell"];
        
        cell.planTitleLabel.text = @"结束时间：";
        
        // 判断该分区是否有数据
        if (_dataSourceArr.count != 0 && _dataSourceArr.count > indexPath.section) {
            
            Task *taskObj = [_dataSourceArr objectAtIndex:indexPath.section];
            
            cell.timeLabel.text = taskObj.endTime;
            
        }
        else
        {
            cell.timeLabel.text = @"请选择结束时间";
        }
        
        return cell;
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
    if (indexPath.row == 1 || indexPath.row == 2) {
        
        if (_timePiker) {
            
            [_timePiker removeFromSuperview];
            
        }
        
        [self.view endEditing:YES];
        
        [self putPickerViewWithSectionNum:indexPath.section RowNum:indexPath.row];
        
    }
    
}

#pragma mark 添加分区按钮点击方法 - 添加任务
- (void)didClickedAddSection
{
    // 添加新分区前，先存储旧分区
    if ([self saveSectionWithSectionNum:_sectionCount - 1]) {
        
        _sectionCount += 1;
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:_sectionCount - 1];
        
        [_mainTableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
    
}

/**
 *  保存分区数据
 *
 *  @param sectionNum 需要保存数据的分区号
 */
- (BOOL)saveSectionWithSectionNum:(NSInteger)sectionNum
{
    
    NSLog(@"%ld", sectionNum);
    // 计划标题
    //    NSIndexPath *planTitleIndexPath         = [NSIndexPath indexPathForRow:0 inSection:0];
    //    LTPlanTitleTableViewCell *planTitleCell = [_mainTableView cellForRowAtIndexPath:planTitleIndexPath];
    
    // task标题
    NSIndexPath *titleIndexPath             = [NSIndexPath indexPathForRow:0 inSection:sectionNum];
    LTPlanTitleTableViewCell *titleCell     = [_mainTableView cellForRowAtIndexPath:titleIndexPath];
    
    // 开始时间
    NSIndexPath *startTimeIndexPath         = [NSIndexPath indexPathForRow:1 inSection:sectionNum];
    LTTimePickerTableViewCell *startCell    = [_mainTableView cellForRowAtIndexPath:startTimeIndexPath];
    
    // 结束时间
    NSIndexPath *endTimeIndexPath           = [NSIndexPath indexPathForRow:2 inSection:sectionNum];
    LTTimePickerTableViewCell *endCell      = [_mainTableView cellForRowAtIndexPath:endTimeIndexPath];
    
    // 验证计划名称是否为空
//    if (![self isBlankString:planTitleCell.planTitleTextField.text]) {
    
        // 验证task名是否为空
        if (![self isBlankString:titleCell.planTitleTextField.text]) {
            
            // 验证开始时间是否为空
            if (![self isBlankString:startCell.timeLabel.text] && ![startCell.timeLabel.text isEqualToString:@"请选择开始时间"]) {
                
                // 验证结束时间是否为空
                if (![self isBlankString:endCell.timeLabel.text] && ![endCell.timeLabel.text isEqualToString:@"请选择结束时间"]) {
                    
                    Task *task = [self getTaskInfoById:sectionNum andPlanId:_planId];
                    
                    // 判断未存储过该条信息，则创建新的task对象
                    if (task == nil) {
                        
                        task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
                    }
                    
                    task.taskId     = [NSNumber numberWithInteger:sectionNum];
                    
                    // 给实体类赋值
                    task.planName   = _planTitle;
                    
                    task.planId     = [NSNumber numberWithInteger:_planId];
                    
                    task.endTime    = endCell.timeLabel.text;
                    
                    task.taskName   = titleCell.planTitleTextField.text;
                    
                    task.startTime  = startCell.timeLabel.text;
                    
                    [_dataSourceArr addObject:task];
                    
                    // 验证全部通过 保存
//                    [_ltCoreDataManager saveContext];
                    
                    // 将存储对象制空
//                    task = nil;
                    
//                    [self selectTasks];
                }
                else
                {
                    NSLog(@"结束时间为空！");
                    
                    return NO;
                }
            }
            else
            {
                NSLog(@"开始时间为空！");
                
                return NO;
            }
        }
        else
        {
            NSLog(@"task名称为空！");
            
            return NO;
        }
//    }
//    else
//    {
//        NSLog(@"计划名称为空！");
//        
//        return NO;
//    }

    return YES;
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

#pragma mark 保存task方法
- (BOOL)saveTask
{
    if ([_dataSourceArr count] != 0) {
        
        for (Task *task in _dataSourceArr) {
            
            Task *taskObj = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
            
            taskObj.taskId     = task.taskId;
            
            // 给实体类赋值
            taskObj.planName   = task.planName;
            
            taskObj.planId     = task.planId;
            
            taskObj.endTime    = task.endTime;
            
            taskObj.taskName   = task.taskName;
            
            taskObj.startTime  = task.startTime;
            
            [_ltCoreDataManager saveContext];
        }
        
        return YES;
    }
    else
    {
        NSLog(@"没有任务可保存");
        
        return NO;
    }
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

#pragma mark 查询方法
- (void)selectTasks{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(planId == %ld)", _planId];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *fetchObjArr = [_ltCoreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchObjArr == nil) {
        
        NSLog(@"%@", error);
    }
    
    NSMutableArray *dataArray = fetchObjArr.mutableCopy;
    
    // 更新数据源数组
    _dataSourceArr = dataArray;
    
    for (Task *taskObj in dataArray) {
        
        NSLog(@"Plan名称：%@ - Task名称：%@ - 开始时间：%@ - 结束时间：%@", taskObj.planName, taskObj.taskName, taskObj.startTime, taskObj.endTime);
        
    }
    
}

// 删除方法
- (void)deleteTaskWithTaskId:(NSInteger)taskId andPlanId:(NSInteger)planId{
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(taskId == %ld) && (planId == %ld)", taskId, planId];
    
    [fetchRequest setPredicate:predicate];
    
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    
    NSArray *fetchArr = [_ltCoreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // 判断是否查询出结果
    if (fetchArr && [fetchArr count] > 0) {
        
        // 遍历数组删除符合条件的对象
        [fetchArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [_ltCoreDataManager.managedObjectContext deleteObject:obj];
            
        }];
        
    }
    
    // 保存上下文
    if (_ltCoreDataManager.managedObjectContext.hasChanges) {
        
        [_ltCoreDataManager.managedObjectContext save:nil];
    }
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Delete Data Error : %@", error);
    }
    
    [self selectTasks];
    
    
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
