#import "Movie+Detail+Model.h"
@interface Movie_URL_Manager : NSObject
+ (void)MovieDetail:(long)id
            Headers:(NSDictionary *)headers
           Complete:(void (^)(Movie_Detail_Model *movie_detail_model))completeHandler
             Failed:(void (^)(NSString *message))failedHandler
            Expired:(void (^)())expiredHandler
              Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)MovieLike:(long)id
          Headers:(NSDictionary *)headers
         Complete:(void (^)())completeHandler
           Failed:(void (^)())failedHandler
            Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)MovieUnlike:(long)id
            Headers:(NSDictionary *)headers
           Complete:(void (^)())completeHandler
             Failed:(void (^)())failedHandler
              Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)MovieReview:(long)id
        Description:(NSString *)description
               Rate:(long)rate
            Headers:(NSDictionary *)headers
           Complete:(void (^)(NSDictionary *result))completeHandler
             Failed:(void (^)(NSString *message))failedHandler
              Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
@end