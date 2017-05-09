//
//  AppDelegate+LTRongCloud.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/5/8.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "AppDelegate+LTRongCloud.h"

@implementation AppDelegate (LTRongCloud)

- (void)setupRongCloud
{
    // 初始化融云
    [[RCIM sharedRCIM] initWithAppKey:@"82hegw5u83btx"];
}

@end
