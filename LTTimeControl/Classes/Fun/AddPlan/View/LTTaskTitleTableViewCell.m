//
//  LTTaskTitleTableViewCell.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/22.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTTaskTitleTableViewCell.h"

@implementation LTTaskTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _taskTitleTextField = [UITextField new];
        
        [self.contentView addSubview:_taskTitleTextField];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_taskTitleTextField makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 20 * kWIDTHFIT, 0, 0));
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
