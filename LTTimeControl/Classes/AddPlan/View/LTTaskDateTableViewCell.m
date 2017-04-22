//
//  LTTaskDateTableViewCell.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/22.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTTaskDateTableViewCell.h"

@implementation LTTaskDateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _titleLabel = [UILabel new];
        _timeLabel = [UILabel new];
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_timeLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(0);
        
        make.width.equalTo(50 * kWIDTHFIT);
        
        make.bottom.equalTo(self).offset(0);
        
        make.left.equalTo(self).offset(20 * kWIDTHFIT);
        
    }];
    
    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(0);
        
        make.right.equalTo(self).offset(-20);
        
        make.bottom.equalTo(self).offset(0);
        
        make.left.equalTo(self.titleLabel.right).offset(0);
        
    }];
    
    _timeLabel.textAlignment = NSTextAlignmentRight;
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
