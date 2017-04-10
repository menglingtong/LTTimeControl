//
//  Plan+CoreDataProperties.h
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/10.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "Plan+CoreDataClass.h"
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Plan (CoreDataProperties)

+ (NSFetchRequest<Plan *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *planId;
@property (nullable, nonatomic, copy) NSString *planName;
@property (nullable, nonatomic, copy) NSNumber *isOn;
@property (nullable, nonatomic, retain) NSSet<Task *> *task;

@end

@interface Plan (CoreDataGeneratedAccessors)

- (void)addTaskObject:(Task *)value;
- (void)removeTaskObject:(Task *)value;
- (void)addTask:(NSSet<Task *> *)values;
- (void)removeTask:(NSSet<Task *> *)values;

@end

NS_ASSUME_NONNULL_END
