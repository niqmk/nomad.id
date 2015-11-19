#import "Menu+Model.h"
#import "Slider+Model.h"
#import "Search+Model.h"
#import "Paid+Point+Model.h"
#import "Free+Point+Model.h"
@interface URL_Manager : NSObject
+ (void)Get:(NSString *)url
    Headers:(NSDictionary *)headers
   Complete:(void (^)(NSDictionary *response))completeHandler
     Failed:(void (^)(NSString *message))failedHandler
      Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)Login:(NSString *)username
     Password:(NSString *)password
     Complete:(void (^)(NSDictionary *response))completeHandler
       Failed:(void (^)(NSString *message))failedHandler
        Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)Register:(NSString *)email
        Username:(NSString *)username
        Password:(NSString *)password
PasswordConfirmation:(NSString *)password_confirmation
        Complete:(void (^)(NSDictionary *response))completeHandler
          Failed:(void (^)(NSString *message))failedHandler
           Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)FBLogin:(NSString *)fb_id
          Email:(NSString *)email
       Fullname:(NSString *)full_name
       Complete:(void (^)(NSDictionary *response))completeHandler
         Failed:(void (^)(NSString *message))failedHandler
          Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)ForgotPassword:(NSString *)email
              Complete:(void (^)(NSString *message))completeHandler
                Failed:(void (^)(NSString *message))failedHandler
                 Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)Me:(void (^)(Me_Model *me_model))completeHandler
    Failed:(void (^)(NSString *message))failedHandler
   Expired:(void (^)())expiredHandler
     Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)Menus:(void (^)(Menu_Model *menu_model))completeHandler
        Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)Slider:(void (^)(Slider_Model *slider_model))completeHandler
         Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)Search:(NSString *)key
      Complete:(void (^)(Search_Model *search_model))completeHandler
        Failed:(void (^)(NSString *message))failedHandler
         Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)Buy:(long)video_id
  VideoType:(VideoType)video_type
    PriceID:(long)price_id
   Complete:(void (^)(NSDictionary *response))completeHandler
     Failed:(void (^)(NSString *message))failedHandler
      Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)BuyStatus:(long)video_id
        VideoType:(VideoType)video_type
         Complete:(void (^)(NSDictionary *response))completeHandler
           Failed:(void (^)(NSString *message))failedHandler
            Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)PaidPoint:(void (^)(Paid_Point_Model *paid_point_model))completeHandler
           Failed:(void (^)(NSString *message))failedHandler
            Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)PaidPointBuy:(long)id
            Complete:(void (^)(NSDictionary *response))completeHandler
              Failed:(void (^)(NSString *message))failedHandler
             Expired:(void (^)())expiredHandler
               Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)FreePoint:(void (^)(Free_Point_Model *free_point_model))completeHandler
           Failed:(void (^)(NSString *message))failedHandler
            Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
@end