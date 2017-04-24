//
//  LTTaskWithOrderModel.h
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/24.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTTaskWithOrderModel : LTBaseModel

@property (nonatomic, strong) NSString *startTime;

@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) NSString *taskName;

@property (nonatomic, strong) NSMutableArray *timeDataSourceArr;

- (instancetype)initWithStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andTaskName:(NSString *)taskName;

- (NSComparisonResult)compareWithStartTime:(LTTaskWithOrderModel *)otherTask;

@end
