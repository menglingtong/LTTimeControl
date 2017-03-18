//
//  LTAddPlanTitleViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/3/18.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTAddPlanTitleViewController.h"

#import "LTAddPlanViewController.h"

#import "LTCoreDataManager.h"

#import "Plan.h"

@interface LTAddPlanTitleViewController ()

@property (nonatomic, strong) UITextField *planTitle;

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) LTCoreDataManager *coreDataManager;

@end

@implementation LTAddPlanTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加计划";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedGoBack)];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - 64)];
    
    _mainScrollView.scrollEnabled = YES;
    
    [self.view addSubview:_mainScrollView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(30 * kWIDTHFIT, 30 * kHEIGHTFIT, kSCREENWIDTH - 60 * kWIDTHFIT, 30 * kHEIGHTFIT)];
    title.text = @"计划名称";
    
    title.textAlignment = 1;
    
    [_mainScrollView addSubview:title];
    
    _planTitle = [[UITextField alloc] initWithFrame:CGRectMake(30 * kWIDTHFIT, 70 * kHEIGHTFIT, kSCREENWIDTH - 60 * kWIDTHFIT, 40 * kHEIGHTFIT)];
    
    _planTitle.backgroundColor = [UIColor whiteColor];
    
    _planTitle.layer.cornerRadius = kCORNERRADIUS;
    
    _planTitle.textAlignment = 1;
    
    [_mainScrollView addSubview:_planTitle];
    
    UIButton *nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
    
    nextStep.frame = CGRectMake(30 * kWIDTHFIT, 220 * kHEIGHTFIT, kSCREENWIDTH - 60 * kWIDTHFIT, 30 * kHEIGHTFIT);
    
    [nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    
    [nextStep setBackgroundColor:kBUTTONBGCOLOR];
    
    nextStep.layer.cornerRadius = kCORNERRADIUS;
    
    [nextStep addTarget:self action:@selector(didClickedNextStep:) forControlEvents:UIControlEventTouchUpInside];
    
    [_mainScrollView addSubview:nextStep];
    
    _coreDataManager  = [LTCoreDataManager shareLTCoreDataManager];
}

- (void)didClickedNextStep:(id)sender{
    
    if ([self savePlanTitle]) {
        
        LTAddPlanViewController *addPlan = [LTAddPlanViewController new];
        
        [self.navigationController pushViewController:addPlan animated:YES];
    }
    else
    {
        NSLog(@"存储不成功");
    }
}

- (BOOL)savePlanTitle{
    
    NSInteger isSave = 0;
    
    Plan *planObj = [self getPlanInfoById:_planId];
    
    if (planObj != nil) {
        
        planObj = [NSEntityDescription insertNewObjectForEntityForName:@"Plan" inManagedObjectContext:_coreDataManager.managedObjectContext];
        
    }
    
    if (![self isBlankString:_planTitle.text]) {
        
        planObj.planId = [NSNumber numberWithInteger:_planId];
        
        planObj.planName = _planTitle.text;
        
        [_coreDataManager saveContext];
        
        isSave = 1;
        
    }
    
    planObj = nil;
    
    return isSave;
    
}

- (Plan *)getPlanInfoById:(NSInteger)planId
{
    Plan *planObj = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Plan" inManagedObjectContext:_coreDataManager.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchLimit:1];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"planId == %ld", planId];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *fetchArr = [_coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        
        NSLog(@"%@", error);
    }
    
    if (fetchArr && fetchArr.count >0) {
        
        planObj = [fetchArr firstObject];
    }
    
    return planObj;
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
