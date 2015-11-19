#import "URL+Controller.h"
@implementation URL_Controller
+ (AFHTTPRequestOperationManager *)getAuthorizeManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet set];
    return manager;
}
+ (AFHTTPRequestOperationManager *)getAuthorizeManager:(NSDictionary *)headers {
    AFHTTPRequestOperationManager *manager = [URL_Controller getAuthorizeManager];
    for(NSString *each in headers) {
        [manager.requestSerializer setValue:[headers objectForKey:each] forHTTPHeaderField:each];
    }
    return manager;
}
+ (void)post:(NSString *)url
     Headers:(NSDictionary *)headers
  Parameters:(NSDictionary *)parameters
    Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
       Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    AFHTTPRequestOperationManager *manager = [URL_Controller getAuthorizeManager:headers];
    [URL_Controller post:manager
                     URL:url
              Parameters:parameters
    Complete:^(NSInteger status_code, NSDictionary *data) {
        completeHandler(status_code, data);
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)post:(NSString *)url
     Headers:(NSDictionary *)headers
  Parameters:(NSDictionary *)parameters
       Image:(NSData *)image
    Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
       Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    AFHTTPRequestOperationManager *manager = [URL_Controller getAuthorizeManager:headers];
    [URL_Controller post:manager
                     URL:url
              Parameters:parameters
                   Image:image
    Complete:^(NSInteger status_code, NSDictionary *data) {
        completeHandler(status_code, data);
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)post:(AFHTTPRequestOperationManager *)manager
         URL:(NSString *)url
  Parameters:(NSDictionary *)parameters
    Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
       Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [manager POST:url
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = operation.responseString;
        NSDictionary *result = nil;
        if([Global_Controller isNotNull:response]) {
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        completeHandler([operation.response statusCode], result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *result = nil;
        NSString *response = operation.responseString;
        if([Global_Controller isNotNull:response]) {
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        errorHandler([operation.response statusCode], result);
    }];
}
+ (void)post:(AFHTTPRequestOperationManager *)manager
         URL:(NSString *)url
  Parameters:(NSDictionary *)parameters
       Image:(NSData *)image
    Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
       Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    NSString *file_path = [Global_Controller saveImage:image FileName:@"image.jpg"];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSError *error;
        if([formData appendPartWithFileURL:[NSURL fileURLWithPath:file_path] name:@"image" fileName:@"image.jpg" mimeType:@"image/jpeg" error:&error]) {
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = operation.responseString;
        NSDictionary *result = nil;
        if([Global_Controller isNotNull:response]) {
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        completeHandler([operation.response statusCode], result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *result = nil;
        NSString *response = operation.responseString;
        if([Global_Controller isNotNull:response]) {
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        errorHandler([operation.response statusCode], result);
    }];
}
+ (void)get:(AFHTTPRequestOperationManager *)manager
        URL:(NSString *)url
 Parameters:(NSDictionary *)parameters
   Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
      Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [manager GET:url
      parameters:parameters
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = operation.responseString;
        NSDictionary *result = nil;
        if([Global_Controller isNotNull:response]) {
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        completeHandler([operation.response statusCode], result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *result = nil;
        NSString *response = operation.responseString;
        if([Global_Controller isNotNull:response]) {
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        errorHandler([operation.response statusCode], result);
    }];
}
+ (void)get:(NSString *)url
    Headers:(NSDictionary *)headers
 Parameters:(NSDictionary *)parameters
   Complete:(void (^)(NSInteger, NSDictionary *))completeHandler
      Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    AFHTTPRequestOperationManager *manager = [URL_Controller getAuthorizeManager:headers];
    [URL_Controller get:manager URL:url
             Parameters:parameters
    Complete:^(NSInteger status_code, NSDictionary *data) {
        completeHandler(status_code, data);
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
@end