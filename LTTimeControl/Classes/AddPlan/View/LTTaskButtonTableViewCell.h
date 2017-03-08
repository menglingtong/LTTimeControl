//
//  LTTaskButtonTableViewCell.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

// 删除按钮block
typedef void(^deleteBlock)(NSInteger);

@interface LTTaskButtonTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, assign) NSInteger sectionNum;

@property (nonatomic, copy) deleteBlock deleteBlock;

//@property (nonatomic, strong) UIButton *saveBtn;

@end
