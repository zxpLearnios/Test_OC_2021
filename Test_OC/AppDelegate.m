//
//  AppDelegate.m
//  Test_OC
//
//  Created by bavaria on 2021/1/25.
//

#import "AppDelegate.h"
#import "NSDateManager.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *ary =[NSDateManager getDayHourStringWithTimeInterval: 60 * 1000];
    return YES;
}

@end
