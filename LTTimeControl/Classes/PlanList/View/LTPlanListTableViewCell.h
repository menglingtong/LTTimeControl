//
//  LTPlanListTableViewCell.h
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/28.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol planStatementDelegate <NSObject>

- (void)switchPlanStateWithRow:(NSInteger)row andState:(BOOL)state;

@end

@interface LTPlanListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UIView *bottomBoldLine;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UILabel *planTitleLabel;

@property (nonatomic, strong) UILabel *planTimeRangeLabel;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, weak) id<planStatementDelegate> delegate;

/** 是否选中 */
@property (nonatomic, assign) BOOL isOn;

/** 开关 */
@property (nonatomic, strong) UISwitch *switchBtn;

@end
