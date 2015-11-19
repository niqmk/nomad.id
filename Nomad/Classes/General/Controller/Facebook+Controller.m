#import "Facebook+Controller.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@implementation Facebook_Controller
+ (void)login:(UIViewController *)view_controller
     Complete:(void (^)(Facebook_Model *facebook_model))completeHandler
    Cancelled:(void (^)())cancelledHandler
       Failed:(void (^)())failedHandler {
    if([FBSDKAccessToken currentAccessToken]) {
        [Facebook_Controller getUser:^(Facebook_Model *facebook_model) {
            completeHandler(facebook_model);
        } Failed:^{
            failedHandler();
        }];
        return;
    }
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email"]
                 fromViewController:view_controller
    handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if(error) {
            failedHandler();
        }else if (result.isCancelled) {
            cancelledHandler();
        }else {
            [Facebook_Controller getUser:^(Facebook_Model *facebook_model) {
                completeHandler(facebook_model);
            } Failed:^{
                failedHandler();
            }];
        }
    }];
}
+ (void)getUser:(void (^)(Facebook_Model *facebook_model))completeHandler
         Failed:(void (^)())failedHandler {
    if([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, email, name, first_name, last_name"}]
        startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if(!error) {
                Facebook_Model *facebook_model = [Facebook_Model init:result];
                completeHandler(facebook_model);
            }else {
                failedHandler();
            }
        }];
    }
}
@end