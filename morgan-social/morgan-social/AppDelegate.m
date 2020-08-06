//
//  AppDelegate.m
//  morgan-social
//
//  Created by Caleb Caviness on 7/13/20.
//  Copyright © 2020 Caleb Caviness. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Address.h"
@import GoogleMaps;
@import GooglePlaces;
@import GiphyUISDK;
@import GiphyCoreSDK;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ParseClientConfiguration *configuration = [ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration){
        configuration.applicationId = @"morgan";
        configuration.server = @"https://morgan-social.herokuapp.com/parse";
    }];
    [Parse initializeWithConfiguration:configuration];
    [GMSServices provideAPIKey:@"AIzaSyBK1kCQSh1FOaovXlil5LLIV0MKJCP0nWg"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyBK1kCQSh1FOaovXlil5LLIV0MKJCP0nWg"];
    [Giphy configureWithApiKey:@"AWyHAyYgei3RYdhjJY6qLdiqraVTtdog" verificationMode:false];
    [self configureAddress];
    
    return YES;
}

- (void)configureAddress {
    [Address registerSubclass];
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
