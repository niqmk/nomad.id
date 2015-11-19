#import "User+Model.h"
@implementation User_Model
+ (User_Model *)init:(Login_Model *)login_model {
    User_Model *user_model = [[User_Model alloc] init];
    if(login_model == nil) {
        return user_model;
    }
    user_model.id = login_model.id;
    user_model.auth_token = login_model.auth_token;
    user_model.username = login_model.username;
    user_model.fb_id = login_model.fb_id;
    user_model.email = login_model.email;
    user_model.full_name = login_model.full_name;
    user_model.image_url = login_model.image_url;
    user_model.total_points = login_model.total_points;
    return user_model;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        self.id = [decoder decodeObjectForKey:@"id"];
        self.auth_token = [decoder decodeObjectForKey:@"auth_token"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.fb_id = [decoder decodeObjectForKey:@"fb_id"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.full_name = [decoder decodeObjectForKey:@"full_name"];
        self.image_url = [decoder decodeObjectForKey:@"image_url"];
        self.total_points = [decoder decodeIntegerForKey:@"total_points"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.id forKey:@"id"];
    [encoder encodeObject:self.auth_token forKey:@"auth_token"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.fb_id forKey:@"fb_id"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.full_name forKey:@"full_name"];
    [encoder encodeObject:self.image_url forKey:@"image_url"];
    [encoder encodeInteger:self.total_points forKey:@"total_points"];
}
@end