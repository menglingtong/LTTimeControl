//
//  LTDatePicker.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/3/1.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTDatePicker.h"

@interface LTDatePicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *mainPickerView;

@property (nonatomic, strong) UIToolbar *toolBar;

// 根据模式不同，创建不同列数
@property (nonatomic, assign) NSInteger componentNum;


@end

@implementation LTDatePicker

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 默认为时间模式 h : m
        _componentNum = 2;
        
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 30 * kHEIGHTFIT)];
        
        _toolBar.backgroundColor = kBACKGROUNDCOLOR;
        
        [self addSubview:_toolBar];
        
        _mainPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30 * kHEIGHTFIT, kSCREENWIDTH, self.bounds.size.height - 30* kHEIGHTFIT)];
        
        _mainPickerView.delegate = self;
        
        _mainPickerView.dataSource = self;
        
        _mainPickerView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_mainPickerView];
        
    }
    
    return self;
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
            return 60;
        }
    }
    
    return 0;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
