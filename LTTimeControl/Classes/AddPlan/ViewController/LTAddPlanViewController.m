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

@interface LTAddPlanViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIPickerView *timePiker;

@end

@implementation LTAddPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Add Plan";
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedGoBack)];
    
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
    
    [self.view addSubview:_mainTableView];
    
    [self putPickerView];
    
}

- (void)putPickerView {
    
//    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, kSCREENWIDTH, 44)];
//    
//    toolBar.backgroundColor = [UIColor blueColor];
//    
//    [self.view addSubview:toolBar];
    
    _timePiker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT - 200 * kHEIGHTFIT - 64, kSCREENWIDTH, 200 * kHEIGHTFIT)];
    
    _timePiker.delegate = self;
    
    _timePiker.dataSource = self;
    
    _timePiker.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_timePiker];
    
}

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
    if (section == 0) {
        
        return 1;
    }
    else
    {
        return 4;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        LTPlanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        
        cell.planTitleLabel.text = @"计划名称：";
        
        cell.planTitleTextField.placeholder = @"请输入计划名称";
        
        return cell;
    }
    else
    {
        if (indexPath.row == 0) {
            
            LTPlanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
            
            cell.planTitleLabel.text = @"任务名称：";
            
            cell.planTitleTextField.placeholder = @"请输入任务名称";
            
            return cell;
            
        }
        else if(indexPath.row == 3)
        {
            LTTaskButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
            
            return cell;
            
        }else if (indexPath.row == 1)
        {
            LTTimePickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pickerCell"];
            
            cell.planTitleLabel.text = @"开始时间：";
            
            return cell;
        }else if (indexPath.row == 2)
        {
            LTTimePickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pickerCell"];
            
            cell.planTitleLabel.text = @"结束时间：";
            
            return cell;
        }
        
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        
        if (indexPath.row == 1 || indexPath.row == 2) {
            
            NSLog(@"%ld - %ld", indexPath.section, indexPath.row);
            
        }
        
    }
}

#pragma mark UIPickerView 代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        
        return 24;
    }
    else
    {
        return 60;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        return [NSString stringWithFormat:@"%ld", row + 1];
    }
    else
    {
        return [NSString stringWithFormat:@"%ld", row + 1];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%ld - %ld", component, row);
}

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
