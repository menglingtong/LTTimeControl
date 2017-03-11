//
//  Plan+CoreDataProperties.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/3/11.
//  Copyright © 2017年 LryMlt. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Plan.h"

NS_ASSUME_NONNULL_BEGIN

@interface Plan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *planName;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *task;

@end

@interface Plan (CoreDataGeneratedAccessors)

- (void)addTaskObject:(NSManagedObject *)value;
- (void)removeTaskObject:(NSManagedObject *)value;
- (void)addTask:(NSSet<NSManagedObject *> *)values;
- (void)removeTask:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
