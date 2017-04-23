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



// 提示框
@property (nonatomic, strong) UILabel *hintLabel;

@property (nonatomic, strong) NSString *hintStr;

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
    

    // 默认为时间模式 h : m
    _componentNum = 2;
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 30 * kHEIGHTFIT)];
    
    _toolBar.backgroundColor = kBACKGROUNDCOLOR;
    
    [self addSubview:_toolBar];
    
    // 初始化提示框
    _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREENWIDTH - 200 * kWIDTHFIT) / 2.0, 0, 200 * kWIDTHFIT, 30 * kHEIGHTFIT)];
    
    _hintLabel.textAlignment = NSTextAlignmentCenter;
    
    // 24小时制 0 - 59分钟 且允许获取当前时间的时候，才获取当前时间
    if (_datePickerMode == 0 && _isGetCurrentTime == 1) {
        
        _hourValue = [[NSDate date] lt_hour];
        
        _minuteValue = [[NSDate date] lt_minute];
        
        
    }
    
    // 获取当前时间格式
    _hintStr = [self getCurrentMomentTimeHourValue:_hourValue MinuteValue:_minuteValue];
    
    _hintLabel.text = _hintStr;
    
    [_toolBar addSubview:_hintLabel];
    
    // 确定按钮
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    
    confirm.frame = CGRectMake(CGRectGetMaxX(_hintLabel.frame), 0, (kSCREENWIDTH - 200 * kWIDTHFIT) / 2.0, 30 * kHEIGHTFIT);
    
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    
    [confirm setTitleColor:[UIColor colorWithRed:0.04 green:0.22 blue:0.33 alpha:1.00] forState:UIControlStateNormal];
    
    [confirm addTarget:self action:@selector(didClickedConfirmActor:) forControlEvents:UIControlEventTouchUpInside];
    
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

- (void)setHourValue:(NSInteger)hourValue
{
    if (_hourValue != hourValue) {
        
        _hourValue = hourValue;
    }
    
    if (_isGetCurrentTime == 0 && _datePickerMode == 1) {
        
        _hintStr = [self getCurrentMomentTimeHourValue:_hourValue MinuteValue:_minuteValue];
        
        _hintLabel.text = _hintStr;
        
        // 选中当前的小时
        [_mainPickerView selectRow:_hourValue inComponent:0 animated:YES];
    }

}

- (void)setMinuteValue:(NSInteger)minuteValue
{
    if (_minuteValue != minuteValue) {
        
        _minuteValue = minuteValue;
    }
    
    if (_isGetCurrentTime == 0 && _datePickerMode == 1) {
        
        _hintStr = [self getCurrentMomentTimeHourValue:_hourValue MinuteValue:_minuteValue];
        
        _hintLabel.text = _hintStr;
        
        // 选中当前分钟
        if (_minuteValue == 0) {
            [_mainPickerView selectRow:_minuteValue inComponent:1 animated:YES];
        }
        else
        {
            [_mainPickerView selectRow:1 inComponent:1 animated:YES];
        }
        
    }
    
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
    else if (_datePickerMode == 1)
    {
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
    // 24小时制，0-59分钟
    if (_datePickerMode == 0) {
        
        if (component == 0) {
            
            return 24;
        }
        else
        {
            return 59;
        }
    }
    // 24小时制，0 、30分钟
    else if (_datePickerMode == 1){
        if (component == 0) {
            
            return 24;
        }
        else
        {
            return 2;
        }
    }
    
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 24小时制，0-59分钟
    if (_datePickerMode == 0) {
        
        if (component == 0) {
            
            return [NSString stringWithFormat:@"%ld", row];
        }
        else
        {
            
            return [NSString stringWithFormat:@"%ld", row + 1];
        }
    }
    // 24小时制，0 、30分钟
    else if (_datePickerMode == 1)
    {
        if (component == 0) {
            
            return [NSString stringWithFormat:@"%ld", row];
        }
        else
        {
            if (row == 0) {
                return [NSString stringWithFormat:@"0"];
            }
            else
            {
                return [NSString stringWithFormat:@"30"];
            }
        }
    }
    else
    {
        return [NSString stringWithFormat:@"opps!"];
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 24小时制，0-59分钟
    if (_datePickerMode == 0) {
        
        if (component == 0) {
            
            _hourValue = row;
            
        }else if (component == 1) {
            
            _minuteValue = row + 1;
            
        }
    }
    // 24小时制，0 、30分钟
    else if (_datePickerMode == 1)
    {
        if (component == 0) {
            
            _hourValue = row;
            
        }else if (component == 1) {
            
            if (row == 0) {
                
                _minuteValue = 0;
            }
            else
            {
                _minuteValue = 30;
            }
            
        }
    }
    
    
    _hintStr = [self getCurrentMomentTimeHourValue:_hourValue MinuteValue:_minuteValue];
    
    _hintLabel.text = _hintStr;
    
    
}

- (NSString *)getCurrentMomentTimeHourValue:(NSInteger)hourValue MinuteValue:(NSInteger)minuteValue
{
    NSString *currentTime = [NSString string];
    
    if (_hourValue < 10) {
        
        if (_minuteValue < 10) {
            
            currentTime = [NSString stringWithFormat:@"0%ld : 0%ld", _hourValue, _minuteValue];
            
        }
        else
        {
            currentTime = [NSString stringWithFormat:@"0%ld : %ld", _hourValue, _minuteValue];
            
        }
        
    }
    else
    {
        if (_minuteValue < 10) {
            
            currentTime = [NSString stringWithFormat:@"%ld : 0%ld", _hourValue, _minuteValue];
            
        }
        else
        {
            currentTime = [NSString stringWithFormat:@"%ld : %ld", _hourValue, _minuteValue];
            
        }
    }
    
    return currentTime;
}

- (void)didClickedConfirmActor:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmActionWithDatePicker:WithHintStr:WithSection:WithRow:)]) {
        
        [self.delegate confirmActionWithDatePicker:self WithHintStr:_hintStr WithSection:_sectionNum WithRow:_rowNum];
        
    }
    
    [self removeFromSuperview];
}

- (void)removeFromSuperview
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = CGRectMake(0, kSCREENHEIGHT, kSCREENWIDTH, 200 * kHEIGHTFIT);
        
    } completion:^(BOOL finished) {
        
        self.delegate = nil;
        
        [super removeFromSuperview];
        
    }];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
