//
//  LTPlanListViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTPlanListViewController.h"

#import "LTPlanListModel.h"

#import "LTPlanListTableViewCell.h"

#import "LTAddPlanViewController.h"

#import "LTCoreDataManager.h"

#import "Plan.h"

@interface LTPlanListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@property (nonatomic, strong) LTPlanListModel *model;

@property (nonatomic, strong) LTCoreDataManager *ltCoreDataManager;

@end

@implementation LTPlanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedGoBack)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedAddPlan)];
    
    _ltCoreDataManager = [LTCoreDataManager shareLTCoreDataManager];
    
    self.navigationItem.title = @"Plan List";
    
    _dataSourceArr = [NSMutableArray array];
    
    [self selectPlanFromDataBase];
    
    // 导航控制器高度44 电池条20
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - 64) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    
    _mainTableView.dataSource = self;
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mainTableView registerClass:[LTPlanListTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_mainTableView];
    
}

- (void)selectPlanFromDataBase
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Plan" inManagedObjectContext:_ltCoreDataManager.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    
    NSArray *fetchArr = [_ltCoreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    _dataSourceArr = [fetchArr mutableCopy];
    
    for (Plan *planObj in _dataSourceArr) {
        
        NSLog(@"计划：%@", planObj.planName);
    }
    
    [_mainTableView reloadData];
}

- (void)didClickedGoBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickedAddPlan{
    
    LTAddPlanViewController *addPlanVC = [LTAddPlanViewController new];
    
    [self.navigationController pushViewController:addPlanVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTPlanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Plan *planObj = [_dataSourceArr objectAtIndex:indexPath.row];
    
    cell.planTitleLabel.text = planObj.planName;
    
//    cell.planTimeRangeLabel.text = modelForCell.planTimeRange;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
