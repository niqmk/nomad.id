#import "Facebook+Model.h"
@interface Facebook_Controller : NSObject
+ (void)login:(UIViewController *)view_controller
     Complete:(void (^)(Facebook_Model *facebook_model))completeHandler
    Cancelled:(void (^)())cancelledHandler
       Failed:(void (^)())failedHandler;
+ (void)getUser:(void (^)(Facebook_Model *facebook_model))completeHandler
         Failed:(void (^)())failedHandler;
@end