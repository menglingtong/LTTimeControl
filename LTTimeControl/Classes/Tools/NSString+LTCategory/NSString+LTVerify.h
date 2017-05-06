//
//  NSString+LTVerify.h
//  LTTimeControl
//
//  Created by 孟令通 on 2017/5/6.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LTVerify)

/**
 *  判断字符串是否为空
 *
 *  @param string 被判断的字符串
 *
 *  @return 布尔类型
 */
+ (BOOL)isBlank:(NSString *)string;

@end
