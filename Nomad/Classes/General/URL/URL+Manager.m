#import "URL+Manager.h"
#import "URL+Controller.h"
#import "Response+Model.h"
#import "URL+Config.h"
@implementation URL_Manager
+ (void)Get:(NSString *)url
    Headers:(NSDictionary *)headers
   Complete:(void (^)(NSDictionary *))completeHandler
     Failed:(void (^)(NSString *))failedHandler
      Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    url = [NSString stringWithFormat:@"%@%@", url_server, url];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [URL_Controller get:url
                Headers:headers
             Parameters:nil
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
+ (void)Login:(NSString *)username
     Password:(NSString *)password
     Complete:(void (^)(NSDictionary *response))completeHandler
       Failed:(void (^)(NSString *message))failedHandler
        Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler {
    NSDictionary *parameters = @{
                                 @"username" : username,
                                 @"password" : password
                                 };
    [URL_Controller post:[NSString stringWithFormat:url_login, url_server]
                 Headers:nil
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
+ (void)Register:(NSString *)email
        Username:(NSString *)username
        Password:(NSString *)password
PasswordConfirmation:(NSString *)password_confirmation
        Complete:(void (^)(NSDictionary *response))completeHandler
          Failed:(void (^)(NSString *message))failedHandler
           Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler {
    NSDictionary *parameters = @{
                                 @"email": email,
                                 @"username": username,
                                 @"password": password,
                                 @"password_confirmation": password_confirmation
                                 };
    [URL_Controller post:[NSString stringWithFormat:url_register, url_server]
                 Headers:nil
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
+ (void)FBLogin:(NSString *)fb_id
          Email:(NSString *)email
       Fullname:(NSString *)full_name
       Complete:(void (^)(NSDictionary *response))completeHandler
         Failed:(void (^)(NSString *message))failedHandler
          Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler {
    NSDictionary *parameters = @{
                                 @"fb_id" : fb_id,
                                 @"email" : email,
                                 @"full_name" : full_name
                                 };
    [URL_Controller post:[NSString stringWithFormat:url_fb_login, url_server]
                 Headers:nil
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
+ (void)ForgotPassword:(NSString *)email
              Complete:(void (^)(NSString *message))completeHandler
                Failed:(void (^)(NSString *message))failedHandler
                 Error:(void (^)(NSInteger status_code, NSDictionary *response))errorHandler {
    NSDictionary *parameters = @{@"email" : email};
    [URL_Controller post:[NSString stringWithFormat:url_forgot_password, url_server]
                 Headers:nil
              Parameters:parameters
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == FailedStatusCode) {
            failedHandler(response_model.message);
        }else if(response_model.status == SuccessStatusCode) {
            completeHandler(response_model.message);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)Me:(void (^)(Me_Model *))completeHandler
    Failed:(void (^)(NSString *))failedHandler
   Expired:(void (^)())expiredHandler
     Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller get:[NSString stringWithFormat:url_me, url_server]
                Headers:[App_Controller getHeaders]
             Parameters:nil
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == FailedStatusCode) {
            failedHandler(response_model.message);
        }else if(response_model.status == SuccessStatusCode) {
            Me_Model *me_model = [Me_Model init:response_model.result];
            completeHandler(me_model);
        }else if(response_model.status == ExpiredStatusCode) {
            expiredHandler();
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];

}
+ (void)Menus:(void (^)(Menu_Model *))completeHandler
        Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    NSString *url = [NSString stringWithFormat:url_menus, url_server];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [URL_Controller get:url
                Headers:nil
             Parameters:nil
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Menu_Model *menu_model = [Menu_Model init:data];
        completeHandler(menu_model);
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)Slider:(void (^)(Slider_Model *))completeHandler
         Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller get:[NSString stringWithFormat:url_slider, url_server]
                Headers:nil
             Parameters:nil
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == SuccessStatusCode) {
            Slider_Model *slider_model = [Slider_Model init:[response_model.result objectForKey:@"data"]];
            completeHandler(slider_model);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)Search:(NSString *)key
      Complete:(void (^)(Search_Model *))completeHandler
        Failed:(void (^)(NSString *))failedHandler
         Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    NSDictionary *parameters = @{@"key" : key};
    [URL_Controller post:[NSString stringWithFormat:url_search, url_server]
                 Headers:nil
              Parameters:parameters
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == FailedStatusCode) {
            failedHandler(response_model.message);
        }else if(response_model.status == SuccessStatusCode) {
            Search_Model *search_model = [Search_Model init:[response_model.result objectForKey:@"data"]];
            completeHandler(search_model);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)Buy:(long)video_id
  VideoType:(VideoType)video_type
    PriceID:(long)price_id
   Complete:(void (^)(NSDictionary *))completeHandler
     Failed:(void (^)(NSString *))failedHandler
      Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    long video_type_id = video_type;
    NSDictionary *parameters = @{
                                 @"video_id" : [NSNumber numberWithLong:video_id],
                                 @"video_type_id" : [NSNumber numberWithLong:video_type_id],
                                 @"price_id" : [NSNumber numberWithLong:price_id]
                                 };
    [URL_Controller post:[NSString stringWithFormat:url_buy, url_server]
                 Headers:[App_Controller getHeaders]
              Parameters:parameters
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == SuccessStatusCode) {
            completeHandler(response_model.result);
        }else {
            failedHandler(response_model.message);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)BuyStatus:(long)video_id
        VideoType:(VideoType)video_type
         Complete:(void (^)(NSDictionary *))completeHandler
           Failed:(void (^)(NSString *))failedHandler
            Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    long video_type_id = video_type;
    NSDictionary *parameters = @{
                                 @"video_id" : [NSNumber numberWithLong:video_id],
                                 @"video_type_id" : [NSNumber numberWithLong:video_type_id],
                                 };
    [URL_Controller post:[NSString stringWithFormat:url_buy_status, url_server]
                 Headers:[App_Controller getHeaders]
              Parameters:parameters
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == SuccessStatusCode) {
            completeHandler(response_model.result);
        }else {
            failedHandler(response_model.message);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)PaidPoint:(void (^)(Paid_Point_Model *))completeHandler
           Failed:(void (^)(NSString *))failedHandler
            Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller get:[NSString stringWithFormat:url_paid_point, url_server]
                 Headers:nil
              Parameters:nil
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == SuccessStatusCode) {
            Paid_Point_Model *paid_point_model = [Paid_Point_Model init:[response_model.result objectForKey:@"data"]];
            completeHandler(paid_point_model);
        }else {
            failedHandler(response_model.message);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)PaidPointBuy:(long)id
            Complete:(void (^)(NSDictionary *))completeHandler
              Failed:(void (^)(NSString *))failedHandler
             Expired:(void (^)())expiredHandler
               Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    NSDictionary *parameters = @{ @"paid_point_id" : [NSNumber numberWithLong:id] };
    [URL_Controller post:[NSString stringWithFormat:url_paid_point_buy, url_server]
                 Headers:[App_Controller getHeaders]
              Parameters:parameters
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == FailedStatusCode) {
            failedHandler(response_model.message);
        }else if(response_model.status == SuccessStatusCode) {
            completeHandler(response_model.result);
        }else if(response_model.status == ExpiredStatusCode) {
            expiredHandler();
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
+ (void)FreePoint:(void (^)(Free_Point_Model *))completeHandler
           Failed:(void (^)(NSString *))failedHandler
            Error:(void (^)(NSInteger, NSDictionary *))errorHandler {
    [URL_Controller get:[NSString stringWithFormat:url_free_point, url_server]
                Headers:nil
             Parameters:nil
    Complete:^(NSInteger status_code, NSDictionary *data) {
        Response_Model *response_model = [Response_Model init:data];
        if(response_model.status == SuccessStatusCode) {
            Free_Point_Model *free_point_model = [Free_Point_Model init:[response_model.result objectForKey:@"data"]];
            completeHandler(free_point_model);
        }else {
            failedHandler(response_model.message);
        }
    } Error:^(NSInteger status_code, NSDictionary *data) {
        errorHandler(status_code, data);
    }];
}
@end