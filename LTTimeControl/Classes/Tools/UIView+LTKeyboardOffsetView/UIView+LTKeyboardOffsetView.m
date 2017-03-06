//
//  UIView+LTKeyboardOffsetView.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/3/6.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "UIView+LTKeyboardOffsetView.h"

#import <objc/runtime.h>

@implementation UIView (LTKeyboardOffsetView)

static char kkeyboardGap;

static char kltKeyboardOffsetViewDelegate;


// 由于类目不可以直接添加属性，我们可以通过 runtime 的 objc_setAssociatedObject 为 UIView 动态添加属性，和类进行关联
- (void)setKeyboardGap:(CGFloat)keyboardGap
{
    objc_setAssociatedObject(self, &kkeyboardGap, [NSNumber numberWithFloat:keyboardGap], OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)keyboardGap
{
    if (objc_getAssociatedObject(self, &kkeyboardGap) == nil) {
        return 6.0;
    }
    
    return [objc_getAssociatedObject(self, &kkeyboardGap) floatValue];
}

- (void)setLtKeyboardOffsetViewDelegate:(id<LTKeyboardOffsetViewDelegate>)ltKeyboardOffsetViewDelegate
{
    objc_setAssociatedObject(self, &kltKeyboardOffsetViewDelegate, ltKeyboardOffsetViewDelegate, OBJC_ASSOCIATION_RETAIN);
}

- (id<LTKeyboardOffsetViewDelegate>)ltKeyboardOffsetViewDelegate
{
    return objc_getAssociatedObject(self, &kltKeyboardOffsetViewDelegate);
}

// 打开键盘补偿视图
- (void)openKeyboardOffsetView
{
    
    //对系统的某些事件时作出响应只要注册一个观察者即可
    //事件1：每次键盘显示后得到通知就得关心 UIKeyboardDidShowNotification 事件:这里的post是系统自己定义好的，不需要写，只需要添加自己是观察者，且做出相应就可以，观察者名字是系统的，记得不观察的时候要移除监听观察者事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}

// 关闭键盘补偿视图
- (void)closeKeyboardOffsetView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillAppear:(NSNotification *)notification
{
    
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    
}

@end
