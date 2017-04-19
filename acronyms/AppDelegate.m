//
//  AppDelegate.m
//  acronyms
//
//  Created by Cesar Miranda on 4/17/17.
//  Copyright © 2017 Cesar Miranda. All rights reserved.
//

#import "AppDelegate.h"
#import "LongFormTableViewController.h"
#import "Client.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Set the root view controller
    LongFormTableViewController * longFormTableViewController = [[LongFormTableViewController alloc] init];
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:longFormTableViewController];
    
    // Set Root View Controller
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
