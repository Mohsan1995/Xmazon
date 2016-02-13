//
//  AppDelegate.m
//  xmazon
//
//  Created by Quentin on 20/01/2016.
//  Copyright © 2016 Quentin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFOAuth2Manager/AFOauth2Manager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow* window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [MainViewController new]];
    [window makeKeyAndVisible];
    self.window = window;
    // Override point for customization after application launch.
    NSURL *baseURL = [NSURL URLWithString:@"http://xmazon.appspaces.fr"];
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
                                    clientID:@"b3e039df-39a9-4b89-8467-499bed101fd9"
                                      secret:@"27542b4d359fffcbf8a9de29e97788d4d5c609ca"];
    
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"oauth/token"
                                            parameters:@{@"grant_type":@"client_credentials"}
                                               success:^(AFOAuthCredential *credential) {
                                                NSLog(@"Token: %@", credential.accessToken);
                                               }
                                               failure:^(NSError *error) {
                                                   NSLog(@"Error: %@", error);
                                               }];
    
    
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
