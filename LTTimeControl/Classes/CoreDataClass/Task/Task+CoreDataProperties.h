//
//  Task+CoreDataProperties.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/3/12.
//  Copyright © 2017年 LryMlt. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *endTime;
@property (nullable, nonatomic, retain) NSString *startTime;
@property (nullable, nonatomic, retain) NSString *taskName;
@property (nullable, nonatomic, retain) NSString *planName;
@property (nullable, nonatomic, retain) Plan *plan;

@end

NS_ASSUME_NONNULL_END
