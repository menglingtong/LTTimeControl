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

@interface LTPlanListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@property (nonatomic, strong) LTPlanListModel *model;

@end

@implementation LTPlanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedGoBack)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    _dataSourceArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 20; i++) {
        
        @autoreleasepool {
            
            _model = [LTPlanListModel new];
            
            _model.planTitle = [NSString stringWithFormat:@"工作日计划%ld", i];
            
            _model.planTimeRange = @"10:37:59 ~ 20:38:13";
            
            [_dataSourceArr addObject:_model];
            
        }
        
    }
    
    // 导航控制器高度44 电池条20
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - 64) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    
    _mainTableView.dataSource = self;
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mainTableView registerClass:[LTPlanListTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_mainTableView];
    
}

- (void)didClickedGoBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTPlanListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    LTPlanListModel *modelForCell = [_dataSourceArr objectAtIndex:indexPath.row];
    
    cell.planTitleLabel.text = modelForCell.planTitle;
    
    cell.planTimeRangeLabel.text = modelForCell.planTimeRange;
    
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
