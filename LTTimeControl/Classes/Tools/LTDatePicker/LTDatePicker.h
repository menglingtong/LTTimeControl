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
//    LTDatePickerModeTimeTwelve,
//    LTDatePickerModeDate,
//    LTDatePickerModeDateAndTimeTwentyFour,
//    LTDatePickerModeDateAndTimeTwelve,
};

@interface LTDatePicker : UIView

@property (nonatomic, assign) LTDatePickerMode datePickerMode;

- (instancetype)initWithFrame:(CGRect)frame;

@end
