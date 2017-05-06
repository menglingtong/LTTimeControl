//
//  LTRegisterViewController.m
//  LTTimeControl
//
//  Created by 孟令通 on 2017/5/6.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTRegisterViewController.h"

#import <BmobSDK/Bmob.h>

@interface LTRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;

@end

@implementation LTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"注  册";
}

- (IBAction)didClickedRegister:(id)sender {
    
    //往GameScore表添加一条playerName为小明，分数为78的数据
//    BmobObject *UserList = [BmobObject objectWithClassName:@"UserList"];
//    [UserList setObject:@2 forKey:@"uid"];
//    [UserList setObject:@"Amy" forKey:@"userName"];
//    [UserList setObject:@"123456" forKey:@"passWord"];
//    [UserList setObject:@26 forKey:@"age"];
//    [UserList setObject:@"01qjbk3AeZzLs+b8+Yk4How4yHKIfdmAX+KRha22eoeyYcZJG13zps+7uzhV8tfzdaffs6XVBuuR3yLpFaj4Bw==" forKey:@"Token"];
//    [UserList setObject:[NSNumber numberWithBool:YES] forKey:@"verify"];
//    [UserList saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        //进行操作
//        
//        if (isSuccessful) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//            
//        }
//        else
//        {
//            NSLog(@"%@", error);
//        }
//        
//    }];
    
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
