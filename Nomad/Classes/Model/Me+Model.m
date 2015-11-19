#import "Me+Model.h"
@implementation Me_Model
+ (Me_Model *)init:(NSDictionary *)data {
    Me_Model *me_model = [[Me_Model alloc] init];
    if(data == nil) {
        return me_model;
    }
    me_model.fb_id = [data objectForKey:@"fb_id"];
    me_model.username = [data objectForKey:@"username"];
    me_model.email = [data objectForKey:@"email"];
    me_model.full_name = [data objectForKey:@"full_name"];
    me_model.birthday = [data objectForKey:@"birthday"];
    me_model.image_url = [data objectForKey:@"image_url"];
    me_model.total_points = [[data objectForKey:@"total_points"] longValue];
    return me_model;
}
@end