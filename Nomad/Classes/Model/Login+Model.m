#import "Login+Model.h"
@implementation Login_Model
+ (Login_Model *)init:(NSDictionary *)data {
    Login_Model *login_model = [[Login_Model alloc] init];
    if(data == nil) {
        return login_model;
    }
    login_model.id = [data objectForKey:@"id"];
    login_model.fb_id = [data objectForKey:@"fb_id"];
    login_model.username = [data objectForKey:@"username"];
    login_model.email = [data objectForKey:@"email"];
    if([data objectForKey:@"full_name"] != [NSNull null]) {
        login_model.full_name = [data objectForKey:@"full_name"];
    }else {
        login_model.full_name = text_blank;
    }
    if([data objectForKey:@"image_url"] != [NSNull null]) {
        login_model.image_url = [data objectForKey:@"image_url"];
    }else {
        login_model.image_url = text_blank;
    }
    login_model.total_points = [[data objectForKey:@"total_points"] intValue];
    login_model.auth_token = [data objectForKey:@"auth_token"];
    return login_model;
}
@end