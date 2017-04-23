//
//  LTTaskBGColorTableViewCell.h
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/24.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^colorBlock)(UIColor *);

@interface LTTaskBGColorTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *redBtn;

@property (nonatomic, strong) UIButton *greenBtn;

@property (nonatomic, strong) UIButton *blueBtn;

@property (nonatomic, strong) UIButton *yellowBtn;

@property (nonatomic, copy) colorBlock colorBlock;

@end
