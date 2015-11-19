#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Parse/Parse.h>
#import "CustomMMDrawerController.h"
#import "Nav+Controller.h"
#import "Menu+Controller.h"
#import "Menu+Logged+Controller.h"
#import "Land+Controller.h"
#import "Config.h"
@implementation AppDelegate {
@private
    CustomMMDrawerController *drawer_controller;
    Nav_Controller *nav_controller;
    Menu_Controller *menu_controller;
    Menu_Logged_Controller *menu_logged_controller;
    Land_Controller *land_controller;
    Global_Variables *gb_variables;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerForRemoteNotification];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setInitial];
    [self.window makeKeyAndVisible];
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
- (void)applicationWillTerminate:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSDictionary *dictionary = notification.userInfo;
    if([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        if([dictionary objectForKey:@"message"] != nil) {
        }
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *current_installation = [PFInstallation currentInstallation];
    [current_installation setChannels:@[text_blank]];
    [current_installation setDeviceTokenFromData:deviceToken];
    [current_installation saveInBackground];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if([gb_variables->user_session isSession]) {
        if([userInfo objectForKey:@"aps"] != nil) {
            [App_Controller showNotification:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
        }
    }
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [App_Controller refreshMe];
}
- (void)checkSession {
    if([gb_variables->user_session isSession]) {
        [self openHomeController];
    }else {
        nav_controller = nil;
        [self openLandController:true];
    }
}
- (void)openHomeController {
    if(nav_controller == nil) {
        nav_controller = [[Nav_Controller alloc] initWithNibName:@"Nav+Controller" bundle:nil];
        if([gb_variables->user_session isSession]) {
            menu_logged_controller = [[Menu_Logged_Controller alloc] initWithNibName:@"Menu+Logged+Controller" bundle:nil];
            drawer_controller = [[CustomMMDrawerController alloc] initWithCenterViewController:nav_controller leftDrawerViewController:menu_logged_controller];
        }else {
            menu_controller = [[Menu_Controller alloc] initWithNibName:@"Menu+Controller" bundle:nil];
            drawer_controller = [[CustomMMDrawerController alloc] initWithCenterViewController:nav_controller leftDrawerViewController:menu_controller];
        }
        drawer_controller.maximumLeftDrawerWidth = (drawer_controller.view.frame.size.width - 64);
        [drawer_controller setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawer_controller setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        self.window.rootViewController = drawer_controller;
    }else {
        if([gb_variables->user_session isSession]) {
            if([drawer_controller.leftDrawerViewController isKindOfClass:[Menu_Controller class]]) {
                menu_logged_controller = [[Menu_Logged_Controller alloc] initWithNibName:@"Menu+Logged+Controller" bundle:nil];
                drawer_controller.leftDrawerViewController = menu_logged_controller;
            }
        }
        [nav_controller reload];
    }
}
- (void)openLandController:(bool)show_login {
    land_controller = [[Land_Controller alloc] initWithNibName:@"Land+Controller"
                                                        bundle:nil
                                                     ShowLogin:show_login];
    self.window.rootViewController = land_controller;
}
- (void)openHome {
    if(nav_controller == nil) {
        return;
    }
    [nav_controller openDefaultRoot];
}
- (void)openHome:(UIViewController *)view_controller {
    if(nav_controller == nil) {
        return;
    }
    [nav_controller openAsRoot:view_controller];
}
- (void)setInitial {
    gb_variables = [Global_Variables instance];
    [gb_variables initial];
    [FBSDKSettings enableLoggingBehavior:FBSDKLoggingBehaviorNetworkRequests];
    [Parse setApplicationId:parse_app_id
                  clientKey:parse_client_key];
    [self setContinue];
}
- (void)setContinue {
    if([gb_variables->user_session isSession]) {
        [self openHomeController];
    }else {
        [self openLandController:false];
    }
}
- (void)registerForRemoteNotification {
    UIUserNotificationType types = UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *notification_settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notification_settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}
@end