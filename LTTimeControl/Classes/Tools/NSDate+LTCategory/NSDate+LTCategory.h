//
//  NSDate+LTCategory.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/3/2.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LTCategory)

// 获取当前小时
- (NSInteger)lt_hour;

// 获取当前分钟
- (NSInteger)lt_minute;

// 获取当前年-月-日 时-分-秒
- (NSDate *)lt_currentTime;

@end
