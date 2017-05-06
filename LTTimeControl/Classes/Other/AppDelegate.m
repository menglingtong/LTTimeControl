//
//  AppDelegate.m
//  LTTimeControl
//
//  Created by 孟令通 on 17/2/24.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "AppDelegate.h"

#import "LTHomePageViewController.h"

#import <BmobSDK/Bmob.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Bmob registerWithAppKey:@"24234f530af7e5a0baf2d0969a41e406"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    LTHomePageViewController *taskVC = [LTHomePageViewController new];
    
    UINavigationController *taskNav = [[UINavigationController alloc] initWithRootViewController:taskVC];
    
    taskNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"任务列表" image:[UIImage imageNamed:@"taskList"] tag:1000];
    
    UIViewController *userVC = [[UIViewController alloc] init];
    
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:userVC];

    userNav.tabBarItem =  [[UITabBarItem alloc] initWithTitle:@"用户" image:[UIImage imageNamed:@"user"] tag:1001];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    
    tabVC.viewControllers = @[taskNav, userNav];
    
    self.window.rootViewController = tabVC;
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
//    [self saveContext];
}

@end
