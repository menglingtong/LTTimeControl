//
//  LTPlanListTableViewCell.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTPlanListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UIView *bottomBoldLine;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *planTitleLabel;

@property (nonatomic, strong) UILabel *planTimeRangeLabel;

@end
