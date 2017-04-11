//
//  LTPlanListTableViewCell.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTPlanListTableViewCell.h"


@implementation LTPlanListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _topLine            = [UIView new];
        _bottomLine         = [UIView new];
        _bottomBoldLine     = [UIView new];
        _planTitleLabel     = [UILabel new];
        _planTimeRangeLabel = [UILabel new];
        _switchBtn          = [UISwitch new];
        
        [self.contentView addSubview:_topLine];
        [self.contentView addSubview:_bottomLine];
        [self.contentView addSubview:_bottomBoldLine];
        [self.contentView addSubview:_planTitleLabel];
        [self.contentView addSubview:_planTimeRangeLabel];
        [self.contentView addSubview:_switchBtn];
        
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
    
    [_bottomBoldLine makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        
        make.bottom.equalTo(self).offset(0);
        
        make.right.equalTo(self).offset(0);
        
        make.height.equalTo(4 * kHEIGHTFIT);
        
    }];
    
    _bottomBoldLine.backgroundColor = kBACKGROUNDCOLOR;
    
    [_bottomLine makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        
        make.bottom.equalTo(_bottomBoldLine.top).offset(0);
        
        make.right.equalTo(self).offset(0);
        
        make.height.equalTo(0.5f);
    }];
    
    _bottomLine.backgroundColor = kLINECOLOR;
    
    [_planTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_topLine.bottom).offset(0);
        
        make.bottom.equalTo(_bottomLine.top).offset(0);
        
        make.left.equalTo(self).offset(12 * kWIDTHFIT);
        
        make.width.equalTo(200 * kWIDTHFIT);
        
    }];
    
    _planTitleLabel.font = [UIFont systemFontOfSize:kTITLEFONTSIZE];
    
    _planTitleLabel.textColor = kTITLEFONTCOLOR;
    
    // 时间显示布局 - 暂不需要 _switchBtn
    [_planTimeRangeLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_topLine.bottom).offset(0);
        
        make.bottom.equalTo(_bottomLine.top).offset(0);
        
        make.left.equalTo(_planTitleLabel.right).offset(12 * kWIDTHFIT);
        
        make.right.equalTo(self).offset(-12 * kWIDTHFIT);
    }];
    
    _planTimeRangeLabel.font = [UIFont systemFontOfSize:kTIMEFONTSIZE];
    
    _planTimeRangeLabel.textColor = kTIMEFONTCOLOR;
    
    _planTimeRangeLabel.textAlignment = 2;
    
    // 开关控件
    [_switchBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_topLine.bottom).offset(10 * kHEIGHTFIT);
        
        make.right.equalTo(self).offset(-12 * kWIDTHFIT);
    }];
    
    [_switchBtn setOn:_isOn];
    
    [_switchBtn addTarget:self action:@selector(didClickedSwitchBtn:) forControlEvents:UIControlEventValueChanged];
    
    
}

- (void)didClickedSwitchBtn:(UISwitch *)switchBtn
{
    if ([_delegate respondsToSelector:@selector(switchPlanStateWithRow:andState:)]) {
        
        [_delegate switchPlanStateWithRow:_row andState:_switchBtn.isOn];
        
    }
}

- (void)setIsOn:(BOOL)isOn
{
    if (isOn != _isOn) {
        
        _isOn = isOn;
        
        NSLog(@"是否选中 %d", isOn);
    }
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
