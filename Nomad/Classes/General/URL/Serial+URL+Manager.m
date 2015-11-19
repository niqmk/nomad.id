#import "Serial+URL+Manager.h"
#import "URL+Controller.h"
#import "Response+Model.h"
#import "URL+Config.h"
@implementation Serial_URL_Manager
+ (void)SerialDetail:(long)id
             Headers:(NSDictionary *)headers
            Complete:(void (^)(Serial_Detail_Model *))completeHandler
              Failed:(void (^)(NSString *))failedHandler
             Expired:(void (^)())expiredHandler
               Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [Serial_URL_Manager Serial:[NSString stringWithFormat:@"%ld", id]
                       Headers:headers
    Complete:^(NSDictionary *response) {
        Serial_Detail_Model *serial_detail_model = [Serial_Detail_Model init:response];
        completeHandler(serial_detail_model);
    } Failed:^(Response_Model *response_model) {
        if(response_model.status == FailedStatusCode) {
            failedHandler(response_model.message);
        }else if(response_model.status == ExpiredStatusCode) {
            expiredHandler();
        }
    } Error:^(NSInteger status_code, NSDictionary *response) {
        errorHandler(status_code, response);
    }];
}
+ (void)ChangeSerialDetail:(long)id
                   Headers:(NSDictionary *)headers
                  Complete:(void (^)(Serial_Detail_Model *))completeHandler
                    Failed:(void (^)(NSString *))failedHandler
                     Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller get:[NSString stringWithFormat:url_serial_detail, url_server, [NSString stringWithFormat:@"%ld", id]]
                Headers:headers
             Parameters:nil
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == SuccessStatusCode) {
            Serial_Detail_Model *serial_detail_model = [Serial_Detail_Model initDetail:response_model.result];
            completeHandler(serial_detail_model);
        }else {
            failedHandler(response_model.message);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)SerialLike:(long)id
           Headers:(NSDictionary *)headers
          Complete:(void (^)())completeHandler
            Failed:(void (^)())failedHandler
             Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller post:[NSString stringWithFormat:url_serial_like, url_server, id]
                 Headers:headers
              Parameters:nil
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == FailedStatusCode) {
            failedHandler();
        }else if(response_model.status == SuccessStatusCode) {
            completeHandler();
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)SerialUnlike:(long)id
             Headers:(NSDictionary *)headers
            Complete:(void (^)())completeHandler
              Failed:(void (^)())failedHandler
               Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller post:[NSString stringWithFormat:url_serial_unlike, url_server, id]
                 Headers:headers
              Parameters:nil
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == FailedStatusCode) {
            failedHandler();
        }else if(response_model.status == SuccessStatusCode) {
            completeHandler();
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)SerialComment:(long)id
          Description:(NSString *)description
              Headers:(NSDictionary *)headers
             Complete:(void (^)(NSDictionary *))completeHandler
               Failed:(void (^)(NSString *))failedHandler
                Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    NSDictionary *parameters = @{
                                 @"description" : description
                                 };
    [URL_Controller post:[NSString stringWithFormat:url_serial_comment, url_server, id]
                 Headers:headers
              Parameters:parameters
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == FailedStatusCode) {
            failedHandler(response_model.message);
        }else if(response_model.status == SuccessStatusCode) {
            completeHandler(response_model.result);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)Serial:(NSString *)sub
       Headers:(NSDictionary *)headers
      Complete:(void (^)(NSDictionary *))completeHandler
        Failed:(void (^)(Response_Model *))failedHandler
         Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller get:[NSString stringWithFormat:url_serial, url_server, sub]
                Headers:headers
             Parameters:nil
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == SuccessStatusCode) {
            completeHandler(response_model.result);
        }else {
            failedHandler(response_model);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
@end