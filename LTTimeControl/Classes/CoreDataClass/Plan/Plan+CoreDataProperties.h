//
//  Plan+CoreDataProperties.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/3/14.
//  Copyright © 2017年 LryMlt. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Plan.h"

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Plan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *planName;
@property (nullable, nonatomic, retain) NSNumber *planId;
@property (nullable, nonatomic, retain) NSSet<Task *> *task;

@end

@interface Plan (CoreDataGeneratedAccessors)

- (void)addTaskObject:(Task *)value;
- (void)removeTaskObject:(Task *)value;
- (void)addTask:(NSSet<Task *> *)values;
- (void)removeTask:(NSSet<Task *> *)values;

@end

NS_ASSUME_NONNULL_END
