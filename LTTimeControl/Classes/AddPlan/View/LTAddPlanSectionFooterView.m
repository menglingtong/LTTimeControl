//
//  LTAddPlanSectionFooterView.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTAddPlanSectionFooterView.h"

@implementation LTAddPlanSectionFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _bottomLine         = [UIView new];
        _bottomBoldLine     = [UIView new];
        
        [self.contentView addSubview:_bottomLine];
        [self.contentView addSubview:_bottomBoldLine];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
