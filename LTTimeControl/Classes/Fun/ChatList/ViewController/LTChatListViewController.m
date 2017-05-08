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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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
