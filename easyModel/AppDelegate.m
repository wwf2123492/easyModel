//
//  AppDelegate.m
//  easyModel
//
//  Created by cdyjy-cdwutao3 on 16/9/23.
//  Copyright © 2016年 horace. All rights reserved.
//

#import "AppDelegate.h"
#import "People.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

  //  jmodel* jm = [[jmodel alloc] initWithDictionary:@{@"i":@(3)} error:nil];
    
    NSDictionary *testDic = @{@"name":@"wwf",
                              @"i":@"-4",
                              @"ui":@"4",
                              @"ni":@"-5",
                              @"uni":@"5",
                              @"f":@"1.6",
                              @"d":@(1.6),
                              @"string":@"stringTest",
                              @"subStrings":@[@"wwf1",@"wwf2"],
                              @"subTypes":@[@{@"subTypeName":@"subname",
                                              @"subi":@(5555)}]
                              
                              
                              };
    testType*  p = [testType modelWithDic:testDic];
  
    subTypeClass* obj = p.subTypes.firstObject;
    NSLog(@"subName:%@  subi:%@",obj.subTypeName,@(obj.subi));
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

@end
