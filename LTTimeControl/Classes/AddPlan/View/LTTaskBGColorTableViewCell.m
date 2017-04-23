//
//  LTTaskBGColorTableViewCell.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/4/24.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTTaskBGColorTableViewCell.h"

@implementation LTTaskBGColorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _greenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _blueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yellowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_redBtn];
        [self.contentView addSubview:_greenBtn];
        [self.contentView addSubview:_blueBtn];
        [self.contentView addSubview:_yellowBtn];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 红色按钮
    [_redBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(60 * kWIDTHFIT);
        
        make.bottom.equalTo(self).offset(-10 * kHEIGHTFIT);
        
        make.top.equalTo(self).offset(10 * kHEIGHTFIT);
        
        make.left.equalTo(self).offset(20 * kWIDTHFIT);
        
    }];
    
    _redBtn.backgroundColor = [UIColor colorWithRed:0.69 green:0.02 blue:0.06 alpha:1.00];
    
    [_redBtn addTarget:self action:@selector(didClickedRedBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 绿色按钮
    [_greenBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(60 * kWIDTHFIT);
        
        make.bottom.equalTo(self).offset(-10 * kHEIGHTFIT);
        
        make.top.equalTo(self).offset(10 * kHEIGHTFIT);
        
        make.left.equalTo(_redBtn.right).offset(20 * kWIDTHFIT);
        
    }];
    
    _greenBtn.backgroundColor = [UIColor colorWithRed:0.13 green:0.62 blue:0.37 alpha:1.00];
    
    [_greenBtn addTarget:self action:@selector(didClickedGreenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 蓝色按钮
    [_blueBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(60 * kWIDTHFIT);
        
        make.bottom.equalTo(self).offset(-10 * kHEIGHTFIT);
        
        make.top.equalTo(self).offset(10 * kHEIGHTFIT);
        
        make.left.equalTo(_greenBtn.right).offset(20 * kWIDTHFIT);
        
    }];
    
    _blueBtn.backgroundColor = [UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:1.00];
    
    [_blueBtn addTarget:self action:@selector(didClickedBlueBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 黄色按钮
    [_yellowBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(60 * kWIDTHFIT);
        
        make.bottom.equalTo(self).offset(-10 * kHEIGHTFIT);
        
        make.top.equalTo(self).offset(10 * kHEIGHTFIT);
        
        make.left.equalTo(_blueBtn.right).offset(20 * kWIDTHFIT);
        
    }];
    
    _yellowBtn.backgroundColor = [UIColor colorWithRed:0.99 green:0.74 blue:0.25 alpha:1.00];
    
    [_yellowBtn addTarget:self action:@selector(didClickedYellowBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickedRedBtn
{
    if (_colorBlock) {
        
        _colorBlock([UIColor colorWithRed:0.69 green:0.02 blue:0.06 alpha:0.40]);
    }
}

- (void)didClickedGreenBtn
{
    if (_colorBlock) {
        
        _colorBlock([UIColor colorWithRed:0.13 green:0.62 blue:0.37 alpha:0.40]);
    }
}

- (void)didClickedBlueBtn
{
    if (_colorBlock) {
        
        _colorBlock([UIColor colorWithRed:0.00 green:0.54 blue:1.00 alpha:0.40]);
    }
}

- (void)didClickedYellowBtn
{
    if (_colorBlock) {
        
        _colorBlock([UIColor colorWithRed:0.99 green:0.74 blue:0.25 alpha:0.40]);
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
