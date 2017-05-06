//
//  LTHomeTaskTableViewCell.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/19.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTHomeTaskTableViewCell.h"

@implementation LTHomeTaskTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _lineLabel = [UILabel new];
        _circleLabel = [UILabel new];
        _timeLabel = [UILabel new];
        _taskNameLabel = [UILabel new];
        
        [self.contentView addSubview:_lineLabel];
        [self.contentView addSubview:_circleLabel];
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_taskNameLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 竖线
    [_lineLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(20);
        
        make.top.equalTo(self).offset(0);
        
        make.bottom.equalTo(self).offset(0);
        
        make.width.equalTo(1);
        
    }];
    
    _lineLabel.backgroundColor = [UIColor colorWithRed:0.52 green:0.84 blue:0.35 alpha:1.00];
    
    // 圆圈
    [_circleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(10);
        
        make.height.equalTo(10);
        
        make.left.equalTo(self).offset(15);
        
        make.top.equalTo(self).offset(15);
        
    }];
    
    _circleLabel.backgroundColor = [UIColor whiteColor];
    
    _circleLabel.layer.cornerRadius = 5;
    
    _circleLabel.layer.masksToBounds = YES;
    
    _circleLabel.layer.borderWidth = 1;
    
    _circleLabel.layer.borderColor = [[UIColor colorWithRed:0.52 green:0.84 blue:0.35 alpha:1.00] CGColor];
    
    // 时间
    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_circleLabel.mas_right).offset(20);
        
        make.top.equalTo(self).offset(0);
        
        make.bottom.equalTo(self).offset(0);
        
        make.width.equalTo(50);
    }];
    
    _timeLabel.textAlignment = 0;
    
    _timeLabel.font = [UIFont systemFontOfSize:15];
    
//    _timeLabel.backgroundColor = [UIColor redColor];
    
    // 任务名
    [_taskNameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_timeLabel.mas_right).offset(20);
        
        make.top.equalTo(self).offset(0);
        
        make.bottom.equalTo(self).offset(0);
        
        make.width.equalTo(200);
        
    }];
    
    _taskNameLabel.textAlignment = 0;
    
    _taskNameLabel.font = [UIFont systemFontOfSize:15];
    
//    _taskNameLabel.backgroundColor = [UIColor greenColor];
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
