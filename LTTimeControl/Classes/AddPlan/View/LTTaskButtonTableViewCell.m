//
//  LTTaskButtonTableViewCell.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTTaskButtonTableViewCell.h"

@implementation LTTaskButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _topLine   = [UIView new];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_deleteBtn];
        
        [self.contentView addSubview:_topLine];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_topLine makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0);
        
        make.top.equalTo(self).offset(0);
        
        make.right.equalTo(self).offset(0);
        
        make.height.equalTo(0.5f);
    }];
    
    _topLine.backgroundColor = kLINECOLOR;
    
    [_deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-12 * kWIDTHFIT);
        
        make.top.equalTo(_topLine.bottom).offset(15 * kHEIGHTFIT);
        
        make.bottom.equalTo(self).offset(-15 * kHEIGHTFIT);
        
        make.width.equalTo(70 * kWIDTHFIT);
        
    }];
    
    [_deleteBtn setBackgroundColor:kWARNING];
    
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _deleteBtn.layer.cornerRadius = kCORNERRADIUS;
    
    [_deleteBtn addTarget:self action:@selector(didClickedDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:kTITLEFONTSIZE];
}

- (void)didClickedDeleteBtn
{
    if (_deleteBtn) {
        
        _deleteBlock(_sectionNum);
        
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
