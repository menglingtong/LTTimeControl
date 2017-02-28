//
//  LTTimePickerTableViewCell.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTTimePickerTableViewCell.h"

@implementation LTTimePickerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _topLine            = [UIView new];
        _planTitleLabel     = [UILabel new];
        
        [self.contentView addSubview:_topLine];
        [self.contentView addSubview:_planTitleLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [_topLine makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        
        make.top.equalTo(self).offset(0);
        
        make.right.equalTo(self).offset(0);
        
        make.height.equalTo(0.5f);
    }];
    
    _topLine.backgroundColor = kLINECOLOR;
    
    [_planTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_topLine.bottom).offset(0);
        
        make.bottom.equalTo(self).offset(0);
        
        make.left.equalTo(self).offset(12 * kWIDTHFIT);
        
        make.width.equalTo(100 * kWIDTHFIT);
        
    }];
    
    _planTitleLabel.font = [UIFont systemFontOfSize:kTITLEFONTSIZE];
    
    _planTitleLabel.textColor = kTITLEFONTCOLOR;
    
    

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
