//
//  LTDatePicker.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/3/1.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LTDatePickerMode) {
    LTDatePickerModeTimeTwentyFour,
    LTDatePickerModeTimeTwentyFourHalf,
//    LTDatePickerModeTimeTwelve,
//    LTDatePickerModeDate,
//    LTDatePickerModeDateAndTimeTwentyFour,
//    LTDatePickerModeDateAndTimeTwelve,
};

@protocol LTNSDatePickerDelegate;

@interface LTDatePicker : UIView

@property (nonatomic, assign) LTDatePickerMode datePickerMode;

@property (nonatomic, assign) id<LTNSDatePickerDelegate> delegate;

@property (nonatomic, assign) BOOL isGetCurrentTime;

@property (nonatomic, assign) NSInteger hourValue;

@property (nonatomic, assign) NSInteger minuteValue;

@property (nonatomic, assign) NSInteger sectionNum;

@property (nonatomic, assign) NSInteger rowNum;


- (instancetype)initWithFrame:(CGRect)frame;

- (void)removeFromSuperview;

@end

// 代理方法
@protocol LTNSDatePickerDelegate <NSObject>

@optional
- (void)confirmActionWithDatePicker:(LTDatePicker *)datePicker WithHintStr:(NSString *)hintStr WithSection:(NSInteger)section WithRow:(NSInteger)row;

@end
