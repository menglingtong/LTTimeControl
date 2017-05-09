//
//  LTChatListViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/5/8.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTChatListViewController.h"

@interface LTChatListViewController ()

@end

@implementation LTChatListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE), @(ConversationType_GROUP), @(ConversationType_DISCUSSION)]];
        
        [self setCollectionConversationType:@[@(ConversationType_PRIVATE)]];
        
        self.showConnectingStatusOnNavigatorBar = YES;
        
        self.isShowNetworkIndicatorView = YES;
    }
    return self;
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    
    if (model.conversationType == ConversationType_PRIVATE) {
        
        RCConversationCell *conversationCell = (RCConversationCell *)cell;
        
        conversationCell.conversationTitle.textColor = [UIColor colorWithRed:0.84 green:0.21 blue:0.20 alpha:1.00];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.cellBackgroundColor = [UIColor colorWithRed:0.99 green:0.74 blue:0.25 alpha:1.00];
//    self.topCellBackgroundColor = [UIColor colorWithRed:0.60 green:0.91 blue:0.41 alpha:1.00];
}


- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        
        LTChatListViewController *temp = [[LTChatListViewController alloc] init];
        
//        NSArray *arr = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationModelType]];
        
        [temp setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE), @(ConversationType_GROUP), @(ConversationType_DISCUSSION)]];
        
        [temp setCollectionConversationType:nil];
        
        temp.isEnteredToCollectionViewController = YES;
        
        [self.navigationController pushViewController:temp animated:YES];
        
    }
    else if (conversationModelType == ConversationType_PRIVATE)
    {
        RCConversationViewController *vc = [[RCConversationViewController alloc] init];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        vc.conversationType = model.conversationType;
        
        vc.targetId = model.targetId;
        
        vc.title = @"会话";
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
