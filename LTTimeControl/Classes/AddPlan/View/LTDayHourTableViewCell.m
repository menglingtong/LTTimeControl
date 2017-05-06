//
//  LTDayHourTableViewCell.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/20.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTDayHourTableViewCell.h"

@implementation LTDayHourTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _timeLabel = [UILabel new];
        _lineLabel = [UILabel new];
        
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_lineLabel];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(0);
        
        make.top.equalTo(self.mas_top).offset(0);
        
        make.height.equalTo(20 * kHEIGHTFIT);
        
        make.width.equalTo(60 * kWIDTHFIT);
        
    }];
    
    _timeLabel.font = [UIFont boldSystemFontOfSize:13];
    
    _timeLabel.textAlignment = 2;
    
    _timeLabel.textColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00];
    
    
    [_lineLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_timeLabel.mas_right).offset(10);
        
        make.top.equalTo(self.mas_top).offset(10 * kHEIGHTFIT);
        
        make.right.equalTo(self.mas_right).offset(0);
        
        make.height.equalTo(0.5);
        
    }];
    
    _lineLabel.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1.00];
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
