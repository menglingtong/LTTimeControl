//
//  Plan+CoreDataProperties.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/10.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "Plan+CoreDataProperties.h"

@implementation Plan (CoreDataProperties)

+ (NSFetchRequest<Plan *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Plan"];
}

@dynamic planId;
@dynamic planName;
@dynamic isOn;
@dynamic task;

@end
