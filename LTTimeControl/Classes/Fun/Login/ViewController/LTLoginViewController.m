//
//  LTLoginViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/5/6.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTLoginViewController.h"

#import "LTRegisterViewController.h"

#import "NSString+LTVerify.h"

#import <BmobSDK/Bmob.h>

#import <RongIMKit/RongIMKit.h>

#import "LTChatListViewController.h"

@interface LTLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userNameImage;
@property (weak, nonatomic) IBOutlet UIImageView *pswImage;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *pswTextField;

@end

@implementation LTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _loginBtn.backgroundColor = [UIColor colorWithRed:0.26 green:0.71 blue:0.94 alpha:1.00];
    
    self.navigationItem.title = @"登  录";
    
}

- (IBAction)didClickedLogin {
    
    NSString *userName = _userNameTextField.text;
    
    NSString *psw = _pswTextField.text;
    
    if (![NSString isBlank:userName]) {
        
        if (![NSString isBlank:psw]) {
            
            //查找GameScore表
            BmobQuery   *query = [BmobQuery queryWithClassName:@"UserList"];
            
            [query whereKey:@"userName" equalTo:userName];
            
            [query whereKey:@"passWord" equalTo:psw];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                if (error) {
                    
                    NSLog(@"%@",error);
                    
                } else {
                    
                    BmobObject *obj = [array firstObject];
                    
                    NSString *token = [obj objectForKey:@"Token"];
                    
                    NSLog(@"%@",[obj objectForKey:@"userName"]);
                    
                    NSLog(@"%@",[obj objectForKey:@"Token"]);
                    
                    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
                        
                        NSLog(@"融云userId：%@", userId);
                        
                        LTChatListViewController *chatListVC = [[LTChatListViewController alloc] init];
                        
//                        chatListVC.displayConversationTypeArray = @[@(ConversationType_PRIVATE)];
                        
                        [self.navigationController pushViewController:chatListVC animated:YES];
                        
                    } error:^(RCConnectErrorCode status) {
                        
                        
                    } tokenIncorrect:^{
                        
                        
                    }];
                    
                }
            }];
            
        }
        else
        {
            NSLog(@"密码不能为空！");
        }
    }
    else
    {
        NSLog(@"用户名为空");
    }
    
    NSLog(@"登录");
}


- (IBAction)didClickedRegister:(id)sender {
    
    LTRegisterViewController *registerVC = [LTRegisterViewController new];
    
    [self.navigationController pushViewController:registerVC animated:YES];
    
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
