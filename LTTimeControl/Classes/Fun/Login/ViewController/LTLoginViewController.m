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

@interface LTLoginViewController ()<RCIMUserInfoDataSource>

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
    
    @weakify(self)
    
    NSString *token = @"GfwHsNMT/FMOBYWp6etCmIw4yHKIfdmAX+KRha22eoeyYcZJG13zpvBaZlrD3Y1P4RbFAgFKxNOR3yLpFaj4Bw==";
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        
        @strongify(self)
        NSLog(@"融云userId：%@", userId);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            
            LTChatListViewController *chatListVC = [[LTChatListViewController alloc] init];
            
            chatListVC.displayConversationTypeArray = @[@(ConversationType_PRIVATE)];
            
            
            [self.navigationController pushViewController:chatListVC animated:YES];
        });
        
        
    } error:^(RCConnectErrorCode status) {
        
        
    } tokenIncorrect:^{
        
        
    }];
    
//    if (![NSString isBlank:userName]) {
//        
//        if (![NSString isBlank:psw]) {
//            
//            //查找GameScore表
//            BmobQuery   *query = [BmobQuery queryWithClassName:@"UserList"];
//            
//            [query whereKey:@"userName" equalTo:userName];
//            
//            [query whereKey:@"passWord" equalTo:psw];
//            
//            
//            
//            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                
//                if (error) {
//                    
//                    NSLog(@"%@",error);
//                    
//                } else {
//                    
//                    BmobObject *obj = [array firstObject];
//                    
//                    NSString *token = [obj objectForKey:@"Token"];
//                    
//                    NSLog(@"%@",[obj objectForKey:@"userName"]);
//                    
//                    NSLog(@"%@",[obj objectForKey:@"Token"]);
//                    
//                    
//                    
//                    
//                    
//                }
//            }];
//            
//        }
//        else
//        {
//            NSLog(@"密码不能为空！");
//        }
//    }
//    else
//    {
//        NSLog(@"用户名为空");
//    }
    
//    NSLog(@"登录");
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    if ([userId isEqualToString:@"2"]) {
        
        RCUserInfo *userInfo1 = [[RCUserInfo alloc] init];
        
        userInfo1.userId = userId;
        
        userInfo1.name = @"Amy";
        
        userInfo1.portraitUri = @"http://opn4bzoai.bkt.clouddn.com/t2.jpg";
        
        return completion(userInfo1);
    }
    else if ([userId isEqualToString:@"3"])
    {
        RCUserInfo *userInfo2 = [[RCUserInfo alloc] init];
        
        userInfo2.userId = userId;
        
        userInfo2.name = @"Jason";
        
        userInfo2.portraitUri = @"http://opn4bzoai.bkt.clouddn.com/t3.jpeg";
        
        return completion(userInfo2);
    }
    
    return completion(nil);
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
