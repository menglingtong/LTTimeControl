//
//  LTDatePicker.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/3/1.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTDatePicker.h"

#import "NSDate+LTCategory.h"

@interface LTDatePicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *mainPickerView;

@property (nonatomic, strong) UIToolbar *toolBar;

// 根据模式不同，创建不同列数
@property (nonatomic, assign) NSInteger componentNum;

@property (nonatomic, assign) NSInteger hourValue;

@property (nonatomic, assign) NSInteger minuteValue;

// 提示框
@property (nonatomic, strong) UILabel *hintLabel;

@end

@implementation LTDatePicker

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        [self defaultInit];
        
    }
    
    return self;
}

// 通过代码创建实例初始化方法
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self defaultInit];
        
    }
    
    return self;
}

// 通过xib创建实例
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self defaultInit];
    }
    
    return self;
}

- (void)defaultInit{
    _hourValue = [[NSDate date] lt_hour];
    
    _minuteValue = [[NSDate date] lt_minute];
    
    // 默认为时间模式 h : m
    _componentNum = 2;
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 30 * kHEIGHTFIT)];
    
    _toolBar.backgroundColor = kBACKGROUNDCOLOR;
    
    [self addSubview:_toolBar];
    
    // 初始化提示框
    _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREENWIDTH - 200 * kWIDTHFIT) / 2.0, 0, 200 * kWIDTHFIT, 30 * kHEIGHTFIT)];
    
    _hintLabel.textAlignment = NSTextAlignmentCenter;
    
    _hintLabel.text = [NSString stringWithFormat:@"%ld : %ld", _hourValue, _minuteValue];
    
    [_toolBar addSubview:_hintLabel];
    
    // 确定按钮
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    
    confirm.frame = CGRectMake(CGRectGetMaxX(_hintLabel.frame), 0, (kSCREENWIDTH - 200 * kWIDTHFIT) / 2.0, 30 * kHEIGHTFIT);
    
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    
    [confirm setTitleColor:[UIColor colorWithRed:0.04 green:0.22 blue:0.33 alpha:1.00] forState:UIControlStateNormal];
    
    
    
    [_toolBar addSubview:confirm];
    
    _mainPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30 * kHEIGHTFIT, kSCREENWIDTH, self.bounds.size.height - 30* kHEIGHTFIT)];
    
    _mainPickerView.delegate = self;
    
    _mainPickerView.dataSource = self;
    
    [_mainPickerView setShowsSelectionIndicator:YES];
    
    // 选中当前的小时
    [_mainPickerView selectRow:_hourValue inComponent:0 animated:YES];
    // 选中当前分钟
    [_mainPickerView selectRow:_minuteValue-1 inComponent:1 animated:YES];
    
    _mainPickerView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_mainPickerView];
}

- (void)setDatePickerMode:(LTDatePickerMode)datePickerMode
{
    if (_datePickerMode != datePickerMode) {
        
        _datePickerMode = datePickerMode;
        
    }
    
    // 根据不同模式设置列数
    if (_datePickerMode == 0) {
        
        _componentNum = 2;
        
        // 刷新时间选择器
        [_mainPickerView reloadAllComponents];
    }
}

#pragma mark UIPickerView 代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _componentNum;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_datePickerMode == 0) {
        
        if (component == 0) {
            
            return 24;
        }
        else
        {
            return 59;
        }
    }
    
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        return [NSString stringWithFormat:@"%ld", row];
    }
    else
    {
        return [NSString stringWithFormat:@"%ld", row + 1];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%ld - %ld", component, row);
    
    if (component == 0) {
        
        _hourValue = row;
        
    }else if (component == 1) {
        
        _minuteValue = row + 1;
        
    }
    if (_hourValue < 10) {
        
        if (_minuteValue < 10) {
            
            _hintLabel.text = [NSString stringWithFormat:@"0%ld : 0%ld", _hourValue, _minuteValue];
        }
        else
        {
            _hintLabel.text = [NSString stringWithFormat:@"0%ld : %ld", _hourValue, _minuteValue];
        }
        
        
    }
    else
    {
        if (_minuteValue < 10) {
            
            _hintLabel.text = [NSString stringWithFormat:@"%ld : 0%ld", _hourValue, _minuteValue];
        }
        else
        {
            _hintLabel.text = [NSString stringWithFormat:@"%ld : %ld", _hourValue, _minuteValue];
        }
    }
    
}

- (void)didClickedConfirmActor:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmActionWithDatePicker:)]) {
        
        [self.delegate confirmActionWithDatePicker:self];
        
    }
    
    
    [self removeFromSuperview];
}

- (void)removeFromSuperview
{
    
    self.delegate = nil;
    [super removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
