//
//  LTTaskWithOrderModel.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/24.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTTaskWithOrderModel.h"

@implementation LTTaskWithOrderModel

- (instancetype)initWithStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andTaskName:(NSString *)taskName
{
    self = [super init];
    
    if (self) {
        
        self.startTime = startTime;
        
        self.endTime = endTime;
        
        self.taskName = taskName;
        
    }
    
    return self;
}

- (NSComparisonResult)compareWithStartTime:(LTTaskWithOrderModel *)otherTask
{
    NSInteger startIndex = [_timeDataSourceArr indexOfObject:_startTime];
    
    NSInteger otherIndex = [_timeDataSourceArr indexOfObject:otherTask.startTime];
    
    if (startIndex > otherIndex) {
        
        return NSOrderedDescending;
    }else if (startIndex == otherIndex){
        
        return NSOrderedSame;
    }
    else
    {
        return NSOrderedAscending;
    }
}

@end
