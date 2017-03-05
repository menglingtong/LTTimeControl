//
//  LTTimePickerTableViewCell.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTTimePickerTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UILabel *planTitleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *timeHintLabel;

@property (nonatomic, assign) NSInteger sectionNum;

@property (nonatomic, assign) NSInteger rowNum;

@end
