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
        
        [self setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE)]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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
