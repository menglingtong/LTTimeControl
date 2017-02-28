//
//  LTPlanListModel.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTBaseModel.h"

@interface LTPlanListModel : LTBaseModel

/** 计划名 */
@property (nonatomic, copy) NSString *planTitle;

/** 计划时间段 */
@property (nonatomic, copy) NSString *planTimeRange;

@end
