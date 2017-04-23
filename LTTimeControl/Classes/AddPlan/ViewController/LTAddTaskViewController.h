//
//  LTAddTaskViewController.h
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/21.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTBaseViewController.h"

@protocol LTAddTaskDelegate <NSObject>
@required
- (void) saveTaskWithTaskName:(NSString *)taskName andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime;

@end

@interface LTAddTaskViewController : LTBaseViewController

@property (nonatomic, strong) NSString *startTime;

@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, assign) NSInteger planId;

@property (nonatomic, assign) id<LTAddTaskDelegate> delegate;

@end
