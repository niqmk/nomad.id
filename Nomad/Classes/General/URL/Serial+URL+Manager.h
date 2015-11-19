#import "Serial+Detail+Model.h"
@interface Serial_URL_Manager: NSObject
+ (void)SerialDetail:(long)id
             Headers:(NSDictionary *)headers
            Complete:(void (^)(Serial_Detail_Model *serial_detail_model))completeHandler
              Failed:(void (^)(NSString *message))failedHandler
             Expired:(void (^)())expiredHandler
               Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)ChangeSerialDetail:(long)id
                   Headers:(NSDictionary *)headers
                  Complete:(void (^)(Serial_Detail_Model *serial_detail_model))completeHandler
                    Failed:(void (^)(NSString *message))failedHandler
                     Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)SerialLike:(long)id
           Headers:(NSDictionary *)headers
          Complete:(void (^)())completeHandler
            Failed:(void (^)())failedHandler
             Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)SerialUnlike:(long)id
             Headers:(NSDictionary *)headers
            Complete:(void (^)())completeHandler
              Failed:(void (^)())failedHandler
               Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler;
+ (void)SerialComment:(long)i
          Description:(NSString *)description
              Headers:(NSDictionary *)headers
             Complete:(void (^)(NSDictionary *result))completeHandler
               Failed:(void (^)(NSString *message))failedHandler
                Error:(void (^)(NSInteger, NSDictionary *))errorHandler;
@end