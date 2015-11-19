#import "Movie+URL+Manager.h"
#import "URL+Controller.h"
#import "Response+Model.h"
#import "URL+Config.h"
@implementation Movie_URL_Manager
+ (void)MovieDetail:(long)id
            Headers:(NSDictionary *)headers
           Complete:(void (^)(Movie_Detail_Model *))completeHandler
             Failed:(void (^)(NSString *))failedHandler
            Expired:(void (^)())expiredHandler
              Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [Movie_URL_Manager Movie:[NSString stringWithFormat:@"%ld", id]
                     Headers:headers
    Complete:^(NSDictionary *response) {
        Movie_Detail_Model *movie_detail_model = [Movie_Detail_Model init:response];
        completeHandler(movie_detail_model);
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
+ (void)MovieLike:(long)id
          Headers:(NSDictionary *)headers
         Complete:(void (^)())completeHandler
           Failed:(void (^)())failedHandler
            Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller post:[NSString stringWithFormat:url_movie_like, url_server, id]
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
+ (void)MovieUnlike:(long)id
            Headers:(NSDictionary *)headers
           Complete:(void (^)())completeHandler
             Failed:(void (^)())failedHandler
              Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller post:[NSString stringWithFormat:url_movie_unlike, url_server, id]
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
+ (void)MovieReview:(long)id
        Description:(NSString *)description
               Rate:(long)rate
            Headers:(NSDictionary *)headers
           Complete:(void (^)(NSDictionary *))completeHandler
             Failed:(void (^)(NSString *))failedHandler
              Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    NSDictionary *parameters = @{
                                 @"description" : description,
                                 @"rate" : [NSNumber numberWithInteger:rate]
                                 };
    [URL_Controller post:[NSString stringWithFormat:url_movie_review, url_server, id]
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
+ (void)Movie:(NSString *)sub
      Headers:(NSDictionary *)headers
     Complete:(void (^)(NSDictionary *))completeHandler
       Failed:(void (^)(Response_Model *))failedHandler
        Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    NSString *url = [NSString stringWithFormat:url_movie, url_server, sub];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [URL_Controller get:url
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