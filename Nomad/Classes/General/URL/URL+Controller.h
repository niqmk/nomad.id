#import <AFNetworking/AFNetworking.h>
@interface URL_Controller : NSObject
+ (AFHTTPRequestOperationManager *)getAuthorizeManager;
+ (AFHTTPRequestOperationManager *)getAuthorizeManager:(NSDictionary *)headers;
+ (void)post:(NSString *)url
     Headers:(NSDictionary *)headers
  Parameters:(NSDictionary *)parameters
    Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
       Error:(void (^)(NSInteger, NSDictionary *))errorHandler;
+ (void)post:(NSString *)url
     Headers:(NSDictionary *)headers
  Parameters:(NSDictionary *)parameters
       Image:(NSData *)image
    Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
       Error:(void (^)(NSInteger, NSDictionary *))errorHandler;
+ (void)post:(AFHTTPRequestOperationManager *)manager
         URL:(NSString *)url
  Parameters:(NSDictionary *)parameters
    Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
       Error:(void (^)(NSInteger, NSDictionary *))errorHandler;
+ (void)post:(AFHTTPRequestOperationManager *)manager
         URL:(NSString *)url
  Parameters:(NSDictionary *)parameters
       Image:(NSData *)image
    Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
       Error:(void (^)(NSInteger, NSDictionary *))errorHandler;
+ (void)get:(AFHTTPRequestOperationManager *)manager
        URL:(NSString *)url
 Parameters:(NSDictionary *)parameters
   Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
      Error:(void (^)(NSInteger, NSDictionary *))errorHandler;
+ (void)get:(NSString *)url
    Headers:(NSDictionary *)headers
 Parameters:(NSDictionary *)parameters
   Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
      Error:(void (^)(NSInteger, NSDictionary *))errorHandler;
@end