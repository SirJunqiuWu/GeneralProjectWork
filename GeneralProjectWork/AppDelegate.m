//
//  AppDelegate.m
//  GeneralProjectWork
//
//  Created by 吴 吴 on 16/3/21.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"

@interface AppDelegate ()
{
    MyTabBarController *myTabBarVC;
    GuideController *guideVC;
    AdvertiseController *adVC;
    LoginController *loginVC;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /**
     * 可随意切换根视图
     */
    [self setWindowWithActionType:Guide];
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
}

#pragma mark - Getter

- (UIViewController *)rootViewController {
    return self.window.rootViewController;
}

- (void)setWindowWithActionType:(AppDelegateTargetActionType)actionType {
    [self removeWindowAllObjects];
    UIViewController *viewController;
    if (actionType == Default || actionType == Home)
    {
        /**
         *  主页
         */
        myTabBarVC = [[MyTabBarController alloc]init];
        
        /**
         *  应用在未开启时收到通知,设置为0
         */
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        viewController = myTabBarVC;
    }
    else if (actionType == Guide)
    {
        /**
         *  引导
         */
        guideVC = [[GuideController alloc]init];
        viewController = guideVC;
    }
    else if (actionType == Ad)
    {
        /**
         *  广告
         */
        adVC = [[AdvertiseController alloc]init];
        viewController = adVC;
    }
    else if (actionType == Login)
    {
        /**
         *  登陆
         */
        loginVC  = [[LoginController alloc]init];
        viewController = loginVC;
    }
    self.window.rootViewController = viewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)removeWindowAllObjects {
    [self.window.rootViewController removeFromParentViewController];
    if (myTabBarVC)
    {
        [myTabBarVC removeFromParentViewController];
        myTabBarVC = nil;
    }
    
    if (guideVC)
    {
        [guideVC removeFromParentViewController];
        guideVC = nil;
    }
    
    if (adVC)
    {
        [adVC removeFromParentViewController];
        adVC = nil;
    }
}

@end
